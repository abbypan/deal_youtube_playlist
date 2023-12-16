#!/usr/bin/perl

my ($mp4_path)  = @ARGV;
exit unless(-d $mp4_path);

system(qq[find "$mp4_path" -type f -exec perl-rename 's/\\s+/-/g' {} \\;]);

my $c=`find "$mp4_path" -type f | sort`;
my @files = split /\n/, $c;
my $i = 0;
my $is = "";
my $fs="";
for (@files){
    next unless(/\.(mp4|rmvb|mkv)$/i);
    $i++;

    $is.=qq[<vlc:item tid="$i"/>\n];

    my $n=$_;
    $n=~s#^.*/##;

    $fs.=qq[
    <track>
    <location>$_</location>
    <title>$n</title>
    <extension application="http://www.videolan.org/vlc/playlist/0">
    <vlc:id>$i</vlc:id>
    </extension>
    </track>
    ];
}

open my $fh,'>', "$mp4_path/playlist.xspf";
print $fh <<__DATA__;
<?xml version="1.0" encoding="UTF-8"?>
<playlist xmlns="http://xspf.org/ns/0/" xmlns:vlc="http://www.videolan.org/vlc/playlist/ns/0/" version="1">
	<title>playlist</title>
	<trackList>
    $fs
	</trackList>
	<extension application="http://www.videolan.org/vlc/playlist/0">
    $is
	</extension>
</playlist>
__DATA__
close $fh;
