{pkgs, ...}: {
  programs.newsboat = {
    enable = true;
    autoReload = true;
    browser = ''"firefox %u >/dev/null 2>&1 &"'';
    urls = [
      {url = "https://celestecaprine.com/feed.rss";}
      {url = "https://nixos.org/blog/announcements-rss.xml";}
      {url = "https://www.phoronix.com/rss.php";}
      {url = "https://www.gamingonlinux.com/article_rss.php";}
    ];
  };
}
