ENV["RAILS_ENV"] = "test"
FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def email_path(action)
    "#{FIXTURES_PATH}/mail_samples/#{action}"
  end

  def read_fixture(mail_file_name)
    IO.readlines(email_path(mail_file_name))
  end
  
  def send_grid_mail
    {"dkim"=>"none", "from"=>"Brian Mulloy <brian@mulloy.us>\n", "text"=>"this is another test.\n", "to"=>"brian+4444@crumpleit.com\n", "subject"=>"Exercise\n", "attachments"=>"0", "headers"=>"Received: by 127.0.0.1 with SMTP id QpKzZ3u8wo\n        Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: from mail-pw0-f49.google.com (unknown [10.9.180.37])\n\tby mx1.send_grid.net (Postfix) with ESMTP id 22FD5464DD6\n\tfor <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: by pwj7 with SMTP id 7so450754pwj.8\n        for <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: by 10.142.229.13 with SMTP id b13mr1309896wfh.349.1280480624172;\n        Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: from [10.0.1.14] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id y16sm2238415wff.14.2010.07.30.02.03.42\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Fri, 30 Jul 2010 02:03:43 -0700 (PDT)\nFrom: Brian Mulloy <brian@mulloy.us>\nContent-Type: text/plain; charset=us-ascii\nContent-Transfer-Encoding: 7bit\nSubject: Exercise\nDate: Fri, 30 Jul 2010 02:03:41 -0700\nMessage-Id: <D77D0F07-E5D5-4396-92E7-712091A7A630@mulloy.us>\nTo: brian+4444@crumpleit.com\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}.symbolize_keys!
  end
  
  def send_grid_html_mail
    {"html"=>"<html><head></head><body style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; \">\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982).&nbsp;<br><br><a href=\"http://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination\">http://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination</a></body></html>", "dkim"=>"none", "from"=>"Brian Mulloy <brian@mulloy.us>\n", "text"=>"\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982). \n\nhttp://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination", "to"=>"brian+4444@crumpleit.com\n", "subject"=>"Crumple\n", "attachments"=>"0", "headers"=>"Received: by 127.0.0.1 with SMTP id kzYPfLTioz\n        Sat, 31 Jul 2010 15:26:52 -0700 (PDT)\nReceived: from mail-pz0-f49.google.com (unknown [10.9.180.37])\n\tby mx1.sendgrid.net (Postfix) with ESMTP id 3F410FE7B8\n\tfor <brian+4444@crumpleit.com>; Sat, 31 Jul 2010 15:26:52 -0700 (PDT)\nReceived: by pzk3 with SMTP id 3so978665pzk.8\n        for <brian+4444@crumpleit.com>; Sat, 31 Jul 2010 15:26:51 -0700 (PDT)\nReceived: by 10.142.156.4 with SMTP id d4mr2828814wfe.288.1280615211679;\n        Sat, 31 Jul 2010 15:26:51 -0700 (PDT)\nReceived: from [10.0.1.19] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id t11sm4930353wfc.4.2010.07.31.15.26.50\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Sat, 31 Jul 2010 15:26:51 -0700 (PDT)\nFrom: Brian Mulloy <brian@mulloy.us>\nContent-Type: multipart/alternative; boundary=Apple-Mail-2--487184309\nSubject: Crumple\nDate: Sat, 31 Jul 2010 15:26:49 -0700\nMessage-Id: <155FE730-FE18-465C-94AE-3425E1C1ACD1@mulloy.us>\nTo: brian+4444@crumpleit.com\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}.symbolize_keys!
  end

end
