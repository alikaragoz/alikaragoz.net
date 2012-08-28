module LayoutHelper
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def gauges(code)
    %Q{<script type="text/javascript">
      var _gauges = _gauges || [];
      (function() {
        var t   = document.createElement('script');
        t.type  = 'text/javascript';
        t.async = true;
        t.id    = 'gauges-tracker';
        t.setAttribute('data-site-id', '#{code}');
        t.src = '//secure.gaug.es/track.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(t, s);
      })();
    </script>}.html_safe if Rails.env.production?
  end

  def google_analytics(code)
    %Q{<script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{code}']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>}.html_safe if Rails.env.production?
  end
end