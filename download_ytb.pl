#!/usr/bin/perl

# config {
my $host = 'foo.xxx.com';
my $web_dir = '/var/www/html';
my $web_path = '/video';
# }

my ($playlist, $end, $start) = @ARGV;
$start ||= 1;


for my $x ( $i .. $n ){
    print "item $x\n";
    system(qq[ansible $host -m shell -a 'rm $web_dir$web_path/*.*']);
    system(qq[ansible $host -m shell -a 'cd $web_dir$web_path && youtube-dl "$playlist" -f mp4 --playlist-items $x']);
    my $c=`ansible $host -m shell -a 'ls $web_dir$web_path'`;
    my @data = grep { /\S/ } (split /\n/sg, $c);
    shift @data;
    system(qq[wget -c "https://$host$web_path/$data[0]"]);
    system(qq[ansible $host -m shell -a 'rm $web_dir$web_path/*.*']);
}
