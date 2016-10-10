module Infisecure
  module ScriptInserter
    BODY_TAG = %r{</body>}

    JS_SCRIPT = %q{
      <script>
        var lnisj1 = '<%= @res["upid"] %>';
        var lnisjs_post_target = '<% @res["js_data_url"] %>';
        function _lnisj_init_post(_) {
          var lnisjPost;
          lnisjPost = window.XMLHttpRequest ? new XMLHttpRequest : new ActiveXObject(
              "Microsoft.XMLHTTP"), lnisjPost
              .open("POST", lnisjs_post_target, !0), lnisjPost.setRequestHeader(
              "Content-type", "application/x-www-form-urlencoded"), lnisjPost
              .send(_)
        }

        var _lnisj1 = "", _lnisj2 = "", _lnisj3 = "", _lnisj4 = "", _lnisj5 = "", _lnisj6 = "";
        _lnisj1 = "json=%7B%22lnisj1%22%3A%22" + lnisj1 + "%22%2C",
        _lnisj2 = "%22lnisj2%22%3A%22"+ encodeURIComponent(navigator.appCodeName) + "%22%2C",
        _lnisj3 = "%22lnisj3%22%3A%22"+ encodeURIComponent(navigator.appVersion) + "%22%2C",
        _lnisj4 = "%22lnisj4%22%3A%22"+ encodeURIComponent(navigator.cookieEnabled) + "%22%2C",
        _lnisj5 = "%22lnisj5%22%3A%22"+ encodeURIComponent(navigator.platform) + "%22%2C",
        _lnisj6 = "%22lnisj6%22%3A%22" + encodeURIComponent(navigator.language) + "%22%2C",
        _lnisj_init_post(_lnisj1 + _lnisj2 + _lnisj3 + _lnisj4 + _lnisj5+ _lnisj6);
      </script>   
    }

    def insert_infisecurejs
      if (
        response.content_type == 'text/html' &&
        response.body.match(BODY_TAG)
      )
        response.body = response.body.gsub(BODY_TAG, JS_SCRIPT + '\\0')
      end      
    end
  end
end