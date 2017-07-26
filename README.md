# deal_youtube_playlist
批量下载youtube播放列表内容，并生成m3u/html播放列表

以vps环境为例，debian系统。

# 安装

    $ apt-get install youtube-dl cpanminus
    $ cpanm File::Slurp

# 例子

假设web服务器路径为 https://foo.xxx.com/, 系统目录为 /var/www/html/

待处理的youtube播放列表为： 新白娘子傳奇唱段合集 https://www.youtube.com/playlist?list=PLF861C755FB66AC6A

假设用vps将视频下载到data子目录

    $ cd /var/www/html
    $ mkdir data
    $ cd data
    $ youtube-dl "https://www.youtube.com/playlist?list=PLF861C755FB66AC6A" -f mp4
    $ rename 's/^\d\d\./0$&/' *.mp4
    $ cd ..
    $ perl gen_video_list.pl https://foo.xxx.com/ data
    https://foo.xxx.com/data/video.m3u
    https://foo.xxx.com/data/video.html

此时，本地可使用浏览器访问 https://foo.xxx.com/data/video.html ，或者用vlc访问 https://foo.xxx.com/data/video.m3u

示例文件: [video.html](data/video.html), [video.m3u](data/video.m3u)
