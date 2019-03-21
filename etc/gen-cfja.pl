use strict;
use utf8;
use File::Basename 'dirname';
my $program = 'gen-cfja';

my $pltotf = 'pltotf';
my $vptovf = 'vptovf';
my $temp = '__cfgn'.$$.'x';

my @shape = qw(
cfjar-b
cfjar-l
cfjar-r
cfjas-b
cfjas-r
cfjas-x
cfjam-r
);

use constant {
  PCptz  => 0xEB4D, #perthousandzero
  PCss   => 0xEB28, #S_S
  PCcwmc => 0xEB12, #cwmcapital
  PCcwma => 0xEB11, #cwmascender
};

use constant NA => undef;

my (%raw_encoding, %encoding);
{
  my $psfd = dirname($0) . "/../PXcjk0.sfd";
  %raw_encoding = %{load_sfd($psfd)};
  # L0J
  $encoding{l0j} = [@{$raw_encoding{l0j}}];
  $encoding{l0j}[0x7B] = 0x002D;
  # L5J (OT1)
  $encoding{l5j} = [@{$raw_encoding{l5j}}];
  $encoding{l5j}[0x7B] = 0x002D;
  # T1
  $encoding{t1} = [@{$raw_encoding{t1}}];
  $encoding{t1}[0x17] = 0x200C; # compwordmark
  $encoding{t1}[0x18] = PCptz;  # perthousandzero
  $encoding{t1}[0x20] = 0x2423; # visiblespace
  $encoding{t1}[0x7F] = 0x002D; # subst for hyphenchar
  $encoding{t1}[0xDF] = PCss;   # S_S
  # TS1
  $encoding{ts1} = [@{$raw_encoding{ts1}}];
  $encoding{ts1}[0x15] = 0x002D; # subst for twelveudash
  $encoding{ts1}[0x16] = 0x002D; # subst for threequartersemdash
  $encoding{ts1}[0x17] = PCcwmc; # cwmcapital
  $encoding{ts1}[0x1F] = PCcwma; # cwmascender
}

my @height = (0.88, 0.75, 0.75, 0.75, 0.5, 0); # other,digit,capital,ascender,x-height,zero
my %htindex = (
  (map { ord($_) => 1 } (split(m//, '0123456789'))),
  (map { ord($_) => 2 } (split(m//, 'ABCDEFGHIJKLMNOPQRSTUVWXYZĄĘŁŊŞȘŢȚĲÆÇÐŒØÞ'))),
  (map { ord($_) => 3 } (split(m//, 'bdfhkltđłţțðþß'))),
  (map { ord($_) => 4 } (split(m//, 'acegijmnopqrsuvwxyząęŋşșĳæçœø'))),
  0x0020 => 5, (PCss) => 2, 0x200C => 4, (PCcwmc) => 2, (PCcwma) => 3,
);

my %ctype = (
  0x2018 => 1, 0x2019 => 2, 0x201C => 1, 0x201D => 2, 0x2015 => 3,
  0x200C => 4, (PCcwmc) => 4, (PCcwma) => 4, (PCss) => 5, (PCptz) => 6, 0x2423 => 7,
);
my %refchar = (
  5 => 0x0053, 6 => 0x2030, 7 => 0x0020,
);
my @special = (
  0x200C, 0x2423, PCss, PCptz, PCcwmc, PCcwma,
);
my @rwidth = (0.5, 1.0, 1.0, 1.0);
my @width = (0.5, 0.5, 0.5, 1.0, 0.0, 1.0, 0.5, 0.5);

my $ligkern_ot1 = <<"EOT";
(LIGTABLE
   (LABEL O 47)
   (LIG O 47 O 42)
   (STOP)
   (LABEL O 140)
   (LIG O 140 O 134)
   (STOP)
   (LABEL O 55)
   (LIG O 55 O 173)
   (STOP)
   (LABEL O 173)
   (LIG O 55 O 174)
   (STOP)
   )
EOT
my $ligkern_t1 = <<"EOT";
(LIGTABLE
   (LABEL O 55)
   (LIG O 55 O 25)
   (LIG O 177 O 177)
   (STOP)
   (LABEL O 140)
   (LIG O 140 O 20)
   (STOP)
   (LABEL O 47)
   (LIG O 47 O 21)
   (STOP)
   (LABEL O 76)
   (LIG O 76 O 24)
   (STOP)
   (LABEL O 74)
   (LIG O 74 O 23)
   (STOP)
   (LABEL O 41)
   (LIG O 140 O 275)
   (STOP)
   (LABEL O 77)
   (LIG O 140 O 276)
   (STOP)
   (LABEL O 25)
   (LIG O 55 O 26)
   (STOP)
   (LABEL O 45)
   (LIG O 30 O 30)
   (STOP)
   (LABEL O 30)
   (LIG O 30 O 30)
   (STOP)
   )
EOT
my %ligkern = (
  l0j => $ligkern_ot1,
  l5j => $ligkern_ot1,
  t1  => $ligkern_t1,
);

sub main {
  foreach my $shp (@shape) {
    make_raw_tfm($shp, 'l0j');
    make_raw_tfm($shp, 'l0j', 1);
    make_raw_tfm($shp, 't1');
    make_raw_tfm($shp, 'ts1');
    make_vf($shp, 'l0j', 'l0j');
    make_vf($shp, 'l5j', 'l0j', 't1', 'ts1');
    make_vf($shp, 't1', 't1', 'ts1');
    make_vf($shp, 'ts1', 'ts1', 't1');
  }
  unlink(glob("$temp.*"));
}

sub rwidth {
  return $rwidth[$ctype{$_[0]} || 0];
}
sub width {
  return $width[$ctype{$_[0]} || 0];
}
sub height {
  local ($_) = @_;
  return $height[$htindex{$_} || 0];
}

sub pl_family {
  local ($_) = @_; s/-\w$//; return uc($_);
}
sub pl_codingscheme {
  local ($_) = @_; return 'ZR-'.uc($_);
}

sub pl_fontdimen {
  return <<"EOT";
(FONTDIMEN
   (SLANT R 0.0)
   (SPACE R 0.5)
   (STRETCH R 0.166667)
   (SHRINK R 0.166667)
   (XHEIGHT R 0.5)
   (QUAD R 1.0)
   (EXTRASPACE R 0.166667)
   )
EOT
}

sub pl_header {
  my ($shp, $enc) = @_;
  my ($fam, $cs) = (pl_family($shp), pl_codingscheme($enc));
  return <<"EOT";
(FAMILY $fam)
(FACE F MRR)
(CODINGSCHEME $cs)
(DESIGNSIZE R 10.0)
EOT
}

sub vpl_header {
  my ($shp, $enc) = @_;
  my ($fam, $cs) = (pl_family($shp), pl_codingscheme($enc));
  return <<"EOT";
(VTITLE $fam)
(FAMILY $fam)
(FACE F MRR)
(CODINGSCHEME $cs)
(DESIGNSIZE R 10.0)
EOT
}

sub make_raw_tfm {
  my ($shp, $enc, $fwid) = @_;
  ($fwid) and $shp .= 'z';
  my $nam = "r-$shp-$enc";
  info("make_raw_tfm", $nam);
  open(my $hp, '>', "$temp.pl") or error("cannot write", "$temp.pl");
  binmode($hp);
  print $hp (pl_header($shp, $enc));
  print $hp (pl_fontdimen());
  my $evec = $raw_encoding{$enc};
  (ref $evec && $#$evec == 255) or error("OOPS(1)");
  foreach my $cc (0 .. 255) {
    my $uc = $evec->[$cc]; (defined $uc) or next;
    my ($wd, $ht) = (rwidth($uc), height($uc));
    (!$fwid || $wd == 1.0) or next;
    print $hp <<"EOT";
(CHARACTER D $cc
   (CHARWD R $wd)
   (CHARHT R $ht)
   )
EOT
  }
  close($hp);
  system("$pltotf $temp $nam");
  ($? == 0) or error("pltotf failure");
}

sub make_vf {
  my ($shp, $enc, @renc) = @_; local ($_);
  my (%map, @rtfm);
  foreach my $rei (0 .. $#renc) {
    my $re = $renc[$rei]; my $evec = $raw_encoding{$re};
    (ref $evec && $#$evec == 255) or error("OOPS(2)");
    push(@rtfm, "r-$shp-$re");
    foreach my $cc (0 .. 255) {
      my $uc = $evec->[$cc]; (defined $uc) or next;
      (!exists $map{$uc}) and $map{$uc} = [$rei, $cc];
    }
  }
  {
    my $re = 'l0j'; my $evec = $raw_encoding{$re};
    push(@rtfm, "r-${shp}z-$re");
    foreach my $cc (0 .. 255) {
      my $uc = $evec->[$cc]; (defined $uc && rwidth($uc) == 1.0) or next;
      $map{$uc} = [$#rtfm, $cc];
    }
  }
  foreach my $uc (@special) { $map{$uc} = [-1, -1]; }
  my $nam = "$shp-$enc";
  info("make_vf", $nam);
  open(my $hp, '>', "$temp.vpl") or error("cannot write", "$temp.vpl");
  binmode($hp);
  print $hp (vpl_header($shp, $enc));
  print $hp (pl_fontdimen());
  foreach my $rei (0 .. $#rtfm) {
    my $t = $rtfm[$rei];
    print $hp <<"EOT";
(MAPFONT D $rei
   (FONTNAME $t)
   )
EOT
  }
  print $hp ($ligkern{$enc});
  my $evec = $encoding{$enc};
  (ref $evec && $#$evec == 255) or error("OOPS(3)");
  foreach my $cc (0 .. 255) {
    my $uc = $evec->[$cc]; (defined $uc) or next;
    my $ucx = sprintf("%X", $uc);
    $_ = $map{$uc} or error("character not available", "0x$ucx");
    my ($rei, $rcc) = @$_;
    my ($wd, $ht, $ct) = (width($uc), height($uc), $ctype{$uc} || 0);
    my ($rrei, $rrcc);
    if (exists $refchar{$ct}) {
      $_ = $map{$refchar{$ct}} or error ("character not available", "RC($ct)");
      ($rrei, $rrcc) = @$_;
    }
    print $hp <<"EOT";
(CHARACTER D $cc
   (CHARWD R $wd)
   (CHARHT R $ht)
   (MAP
EOT
    if ($rei > 0) {
      print $hp <<"EOT";
      (SELECTFONT D $rei)
EOT
    }
    if ($ct == 1) {
      print $hp <<"EOT";
      (MOVERIGHT R -0.5)
      (SETCHAR D $rcc)
EOT
    } elsif ($ct == 4) {
    } elsif ($ct == 5) {
      print $hp <<"EOT";
      (SELECTFONT D $rrei)
      (SETCHAR D $rrcc)
      (SETCHAR D $rrcc)
EOT
    } elsif ($ct == 6) {
      print $hp <<"EOT";
      (SELECTFONT D $rrei)
      (SETCHAR D $rrcc)
EOT
    } elsif ($ct == 7) {
      print $hp <<"EOT";
      (PUSH)
      (MOVEDOWN R 0.12)
      (SETRULE R 0.20 R 0.04)
      (SETRULE R 0.04 R 0.42)
      (SETRULE R 0.20 R 0.04)
      (POP)
      (SELECTFONT D $rrei)
      (SETCHAR D $rrcc)
EOT
    } else {
      print $hp <<"EOT";
      (SETCHAR D $rcc)
EOT
    }
    print $hp <<"EOT";
      )
   )
EOT
  }
  close($hp);
  system("$vptovf $temp $nam $nam");
  ($? == 0) or error("vptovf failure");
}

sub load_sfd {
  my ($fsfd) = @_; local ($_, $/); my (%map);
  info("read sfd", $fsfd);
  open(my $h, '<', $fsfd) or error("cannot read", $fsfd);
  $_ = <$h>;
  close($h);
  s|\t| |g; s|\\ *\n| |mg;
  foreach my $lin (split(m/\n/, $_)) {
    local $_ = $lin; s/^\s+//;
    (m/^\w/) or next;
    my ($enc, @elt) = split(m/\s+/, $_); my $cc = 0;
    ($enc =~ m/^\w+/) or error("bad encoding name", $enc);
    info("encoding", $enc);
    my ($cc, $suc, $euc) = (0, 0, 0); my @vec;
    foreach (@elt) {
      if (m/^(\d+):$/) {
        $cc = $1; next;
      } elsif (m/^(\w+)_(\w+)$/) {
        $suc = number($1); $euc = number($2);
      } elsif (m/^(\w+)$/) {
        $suc = $euc = number($1);
      } else { error("bad token", $_); }
      foreach ($suc .. $euc) { $vec[$cc++] = $_; }
    }
    ($#vec <= 255) or error("vector too long");
    $#vec = 255; $map{$enc} = \@vec;
  }
  return \%map;
}

sub number {
  local ($_) = @_;
  m/^0[xX][0-9a-fA-F]+$/ and return hex($_);
  m/^[0-9]+$/ and return $_-0;
  error("bad number form", $_);
}

sub info {
  print STDERR (join(": ", $program, @_), "\n");
}
sub error {
  info(@_); exit(1);
}

main();
