#!/usr/bin/perl

my ($mp4_path)  = @ARGV;
$mp4_path ||= 'data';

system(qq[find "$mp4_path" -type f -exec rename 's/\\s+/-/g' {} \\;]);

my $c=`find "$mp4_path" -type f | sort`;
my @fc = map {
my $n=$_;
$n=~s#^.*/##;
qq[<li><a target="_blank" href="$_">$n</a></li>];
}
split /\n/, $c;
my $fs = join("\n", @fc);

open my $fh,'>', "video.html";
print $fh <<__DATA__;
<html>
<head>
	<meta http-equiv=Content-Type content="text/html;charset=utf-8">
</head>
<body>
	<div>
	<ul id="video_list">
    $fs
	<ul>
	</div>
</body>
</html>
__DATA__
close $fh;
