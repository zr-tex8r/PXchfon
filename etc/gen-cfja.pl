use strict;
use utf8;
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

use constant NA => undef;

my %raw_encoding = (
  l0j => [
    (NA) x 32, 0x20, 0x21, 0x201D, 0x23 .. 0x26, 0x2019, 0x28 .. 0x3B, NA,
    0x3D, NA, 0x3F .. 0x5B, 0x201C, 0x5D, NA, NA, 0x2018, 0x61 .. 0x7A, NA,
    0x2015, (NA) x 36, 0xFF61 .. 0xFF9F, (NA) x 32
  ],
#  l0jx => [
#    (NA) x 34, 0x201D, (NA) x 4, 0x2019, (NA) x 52, 0x201C, (NA) x 3,
#    0x2018, (NA) x 159
#  ],
);

my %encoding = (
  l0j => [
    (NA) x 32, 0x20, 0x21, 0x201D, 0x23 .. 0x26, 0x2019, 0x28 .. 0x3B, NA,
    0x3D, NA, 0x3F .. 0x5B, 0x201C, 0x5D, NA, NA, 0x2018, 0x61 .. 0x7A, 0x2D,
    0x2015, (NA) x 36, 0xFF61 .. 0xFF9F, (NA) x 32
  ],
  l5j => [
    (NA) x 13, 0x27, (NA) x 4, 0x60, (NA) x 13, 0x20, 0x21, 0x201D,
    0x23 .. 0x26, 0x2019, 0x28 .. 0x5B, 0x201C, 0x5D .. 0x5F, 0x2018,
    0x61 .. 0x7A, 0x2D, 0x2015, NA, 0x7E, (NA) x 129
  ],
  
);

use Data::Dump 'dump';
my @height = (0.88, 0.75, 0.75, 0.75, 0.5, 0);
my %htindex = (
  (map { ord($_) => 1 } (split(m//, '0123456789'))),
  (map { ord($_) => 2 } (split(m//, 'ABCDEFGHIJKLMNOPQRSTUVWXYZĄĘŁŊŞȘŢȚĲÆÇÐŒØÞ'))),
  (map { ord($_) => 3 } (split(m//, 'bdfhkltđłţțðþß'))),
  (map { ord($_) => 4 } (split(m//, 'acegijmnopqrsuvwxyząęŋşșĳæçœø'))),
  (map { ord($_) => 5 } (' ')),
);

my %ctype = (
  0x2018 => 1, 0x2019 => 2, 0x201C => 1, 0x201D => 2, 0x2015 => 3,
);

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
my %ligkern = (
  l0j => $ligkern_ot1,
  l5j => $ligkern_ot1,
);

sub main {
  foreach my $shp (@shape) {
    make_raw_tfm($shp, 'l0j');
    make_raw_tfm($shp, 'l0j', 1);
    make_vf($shp, 'l0j', 'l0j');
  }
  unlink(glob("$temp.*"));
}

sub rwidth {
  local ($_) = @_;
  return (($ctype{$_} || 0) > 0) ? 1.0 : 0.5;
}
sub width {
  local ($_) = @_;
  return (($ctype{$_} || 0) == 3) ? 1.0 : 0.5;
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
  open(my $hp, '>', "$temp.pl") or die; binmode($hp);
  print $hp (pl_header($shp, $enc));
  print $hp (pl_fontdimen());
  my $evec = $raw_encoding{$enc};
  (ref $evec && $#$evec == 255) or die;
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
  ($? == 0) or die;
}

sub make_vf {
  my ($shp, $enc, @renc) = @_; local ($_);
  my (%map, @rtfm);
  foreach my $rei (0 .. $#renc) {
    my $re = $renc[$rei]; my $evec = $raw_encoding{$re};
    (ref $evec && $#$evec == 255) or die;
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
  my $nam = "$shp-$enc";
  info("make_vf", $nam);
  open(my $hp, '>', "$temp.vpl") or die; binmode($hp);
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
  (ref $evec && $#$evec == 255) or die;
  foreach my $cc (0 .. 255) {
    my $uc = $evec->[$cc]; (defined $uc) or next;
    $_ = $map{$uc} or die; my ($rei, $rcc) = @$_;
    my $ucx = sprintf("%X", $uc);
    my ($wd, $ht, $ct) = (width($uc), height($uc), $ctype{$uc} || 0);
    print $hp <<"EOT";
(CHARACTER D $cc
   (CHARWD R $wd)
   (CHARHT R $ht)
   (MAP
EOT
    if ($rei != 0) {
    print $hp <<"EOT";
      (SELECTFONT D $rei)
EOT
    }
    if ($ct == 1) {
    print $hp <<"EOT";
      (MOVERIGHT R -0.5)
      (SETCHAR D $rcc)
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
  ($? == 0) or die;
}

sub info {
  print STDERR (join(": ", @_), "\n");
}

main();
