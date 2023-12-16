# deal_youtube_playlist
批量下载youtube播放列表内容，并生成html播放列表

以vps环境为例，debian系统。

# 安装

    $ apt-get install youtube-dl

# 例子

假设web服务器路径为 https://foo.xxx.com/, 系统目录为 /var/www/html/

待处理的youtube播放列表为： 新白娘子傳奇唱段合集 https://www.youtube.com/playlist?list=PLF861C755FB66AC6A

## 按顺序单文件下载列表中所有视频到本地

假设在远程 foo.xxx.com 的 /var/www/html 下新建一个子目录video，用于单文件下载，随时清空目录。

在 download_ytb.pl 中配置 $host, $web_dir, $web_path

    perl download_ytb.pl [playlist_url] [end_item] [start_item=1]

本地PC下载，需配置ansible

    $ apt-get install ansible wget
    $ perl download_ytb.pl 'https://www.youtube.com/playlist?list=PLtww_vcpAB8roMoQ7xMF1lN4y1C87PaaZ' 50


## 本地生成播放列表

假设本地下载目录为 /mnt/usb/xb
    
    perl gen_playlist.pl [local_dir]

    $ perl gen_playlist.pl /mnt/usb/xb

将生成 /mnt/usb/xb/playlist.xspf
