#!/usr/bin/perl
use File::Slurp qw/slurp write_file/;

my ($web_path, $mp4_path)  = @ARGV;
$web_path=~s#/$##;

system(qq[find "$mp4_path" -name '*.mp4' | sort | sed -e 's#^#$web_path/#' > "$mp4_path/video.m3u"]);

print "$web_path/$mp4_path/video.m3u\n";

my @fc = map {
my $n=$_;
$n=~s#^.*/##;
qq[<li><a target="_blank" href="$_">$n</a></li>];
}
split /\n/,slurp("$mp4_path/video.m3u");
my $fs = join("\n", @fc);
my $s = slurp("video.t");
$s=~s/\[% video_list %\]/$fs/s;
write_file("$mp4_path/video.html", $s);


print "$web_path/$mp4_path/video.html\n";
