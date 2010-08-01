# coding:utf-8

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
    {"dkim"=>"none", "from"=>"Brian Mulloy <brian@mulloy.us>\n", "text"=>"this is another test.\n", "to"=>"brian+4444@crumpleit.com\n", "subject"=>"Exercise\n", "attachments"=>"0", "headers"=>"Received: by 127.0.0.1 with SMTP id QpKzZ3u8wo\n        Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: from mail-pw0-f49.google.com (unknown [10.9.180.37])\n\tby mx1.send_grid.net (Postfix) with ESMTP id 22FD5464DD6\n\tfor <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: by pwj7 with SMTP id 7so450754pwj.8\n        for <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: by 10.142.229.13 with SMTP id b13mr1309896wfh.349.1280480624172;\n        Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: from [10.0.1.14] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id y16sm2238415wff.14.2010.07.30.02.03.42\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Fri, 30 Jul 2010 02:03:43 -0700 (PDT)\nFrom: Brian Mulloy <brian@mulloy.us>\nContent-Type: text/plain; charset=us-ascii\nContent-Transfer-Encoding: 7bit\nSubject: Exercise\nDate: Fri, 30 Jul 2010 02:03:41 -0700\nMessage-Id: <D77D0F07-E5D5-4396-92E7-712091A7A630@mulloy.us>\nTo: brian+4444@crumpleit.com\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}.symbolize_keys
  end
  
  def send_grid_html_mail
    {"html"=>"<html><head></head><body style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; \">\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982).&nbsp;<br><br><a href=\"http://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination\">http://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination</a></body></html>", "dkim"=>"none", "from"=>"Brian Mulloy <brian@mulloy.us>\n", "text"=>"\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982). \n\nhttp://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination", "to"=>"brian+4444@crumpleit.com\n", "subject"=>"Crumple\n", "attachments"=>"0", "headers"=>"Received: by 127.0.0.1 with SMTP id kzYPfLTioz\n        Sat, 31 Jul 2010 15:26:52 -0700 (PDT)\nReceived: from mail-pz0-f49.google.com (unknown [10.9.180.37])\n\tby mx1.sendgrid.net (Postfix) with ESMTP id 3F410FE7B8\n\tfor <brian+4444@crumpleit.com>; Sat, 31 Jul 2010 15:26:52 -0700 (PDT)\nReceived: by pzk3 with SMTP id 3so978665pzk.8\n        for <brian+4444@crumpleit.com>; Sat, 31 Jul 2010 15:26:51 -0700 (PDT)\nReceived: by 10.142.156.4 with SMTP id d4mr2828814wfe.288.1280615211679;\n        Sat, 31 Jul 2010 15:26:51 -0700 (PDT)\nReceived: from [10.0.1.19] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id t11sm4930353wfc.4.2010.07.31.15.26.50\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Sat, 31 Jul 2010 15:26:51 -0700 (PDT)\nFrom: Brian Mulloy <brian@mulloy.us>\nContent-Type: multipart/alternative; boundary=Apple-Mail-2--487184309\nSubject: Crumple\nDate: Sat, 31 Jul 2010 15:26:49 -0700\nMessage-Id: <155FE730-FE18-465C-94AE-3425E1C1ACD1@mulloy.us>\nTo: brian+4444@crumpleit.com\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}.symbolize_keys
  end
  
  def send_grid_utf8_mail
    {"html"=>
      "<html><head></head><body style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; \"><br><div><br><div>Begin forwarded message:</div><br class=\"Apple-interchange-newline\"><blockquote type=\"cite\"><div style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><span style=\"font-family:'Helvetica'; font-size:medium; color:rgba(0, 0, 0, 1);\"><b>From: </b></span><span style=\"font-family:'Helvetica'; font-size:medium;\">Meetup &lt;<a href=\"mailto:info@meetup.com\">info@meetup.com</a>&gt;<br></span></div><div style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><span style=\"font-family:'Helvetica'; font-size:medium; color:rgba(0, 0, 0, 1);\"><b>Date: </b></span><span style=\"font-family:'Helvetica'; font-size:medium;\">July 30, 2010 5:13:21 AM PDT<br></span></div><div style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><span style=\"font-family:'Helvetica'; font-size:medium; color:rgba(0, 0, 0, 1);\"><b>To: </b></span><span style=\"font-family:'Helvetica'; font-size:medium;\"><a href=\"mailto:brian@landlessness.net\">brian@landlessness.net</a><br></span></div><div style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px;\"><span style=\"font-family:'Helvetica'; font-size:medium; color:rgba(0, 0, 0, 1);\"><b>Subject: </b></span><span style=\"font-family:'Helvetica'; font-size:medium;\"><b>The Silicon Valley iPhone and iPad Developers' Meetup Mailing List Daily Digest</b><br></span></div><br><div style=\"color: #212324; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;\">\n\n<h1 style=\"font-size: 1.5em; font-family: tahoma, verdana, sans serif; marg",
     "dkim"=>"none",
     "text"=>
      "Begin forwarded message:\n\n> From: Meetup <info@meetup.com>\n> Date: July 30, 2010 5:13:21 AM PDT\n> To: brian@landlessness.net\n> Subject: The Silicon Valley iPhone and iPad Developers' Meetup Mailing List Daily Digest\n> \n> The Silicon Valley iPhone and iPad Developers' Meetup Mailing List\n> Messages in this digest:\n> 1. Recommend a Hg hosting service? — From: Olie\n> 2. Re: [softwaredev-92] Recommend a Hg hosting service? — From: Michael Mayo\n> 3. IPhone/iPad App Piracy — From: Steven Spry\n> 4. Re: [softwaredev-92] IPhone/iPad App Piracy — From: Rick\n> 5. Re: [softwaredev-92] IPhone/iPad App Piracy — From: Val\n> 1. \t\n> Subject: Recommend a Hg hosting service?\n> From: Olie\n> Date: July 29, 2010 1:56 PM\n> Reply to sender   Reply to Meetup\n>  \t\n> Can any of you recommend a mercurial hosting service that allows me to have some repositories that are private and some that are public? Cheap is good; free is better. \n> \n> Yes, yes -- I Googled. And there are 622,000 results. I was sort of hoping for someone here to tell me \"I use XYZ and really love it\" or \"I tried ABC and they sucked big-time; steer clear!\" \n> \n> Thanks! \n> \n> -- \n> If you add a cup of wine to a barrel of sewage, you have a barrel of sewage. If you add a cup of sewage to a barrel of wine, you have a barrel of sewage. \n> \n> \n> \n> 2. \t\n> Subject: Re: [softwaredev-92] Recommend a Hg hosting service?\n> From: Michael Mayo\n> Date: July 29, 2010 2:48 PM\n> Reply to sender   Reply to Meetup\n>  \t\n> I've used bitbucket.org for mercurial before and it was nice. My personal preference is Github, though. \n> \n> Mike Mayo \n> \n> \n> On Jul 29, 2010, at 10:57 AM, Olie wrote: \n> \n> > Can any of you recommend a mercurial hosting service that allows me to have some repositories that are private and some that are public? Cheap is good; free is better. \n> > \n> > Yes, yes -- I Googled. And there are 622,",
     "from"=>"Brian Mulloy <brian@landlessness.net>\n",
     "action"=>"create_from_sendgrid",
     "to"=>"brian+4444@crumpleit.com\n",
     "subject"=>"Crumple\n",
     "controller"=>"thoughts",
     "attachments"=>"0",
     "headers"=>
      "Received: by 127.0.0.1 with SMTP id 2gGjuH8FTZ\n        Sat, 31 Jul 2010 15:56:20 -0700 (PDT)\nReceived: from mail-pv0-f177.google.com (unknown [10.9.180.37])\n\tby mx1.sendgrid.net (Postfix) with ESMTP id 0B3FAFE7BD\n\tfor <brian+4444@crumpleit.com>; Sat, 31 Jul 2010 15:56:19 -0700 (PDT)\nReceived: by pvf33 with SMTP id 33so982375pvf.8\n        for <brian+4444@crumpleit.com>; Sat, 31 Jul 2010 15:56:19 -0700 (PDT)\nReceived: by 10.114.132.18 with SMTP id f18mr4637752wad.97.1280616979334;\n        Sat, 31 Jul 2010 15:56:19 -0700 (PDT)\nReceived: from [10.0.1.19] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id c10sm7268623wam.13.2010.07.31.15.56.17\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Sat, 31 Jul 2010 15:56:18 -0700 (PDT)\nFrom: Brian Mulloy <brian@landlessness.net>\nContent-Type: multipart/alternative; boundary=Apple-Mail-4--485417586\nSubject: Fwd: The Silicon Valley iPhone and iPad Developers' Meetup Mailing List Daily Digest\nDate: Sat, 31 Jul 2010 15:56:16 -0700\nReferences: <1612922310.1280492001710.JavaMail.meetcvs@jobs.meetup.com>\nTo: brian+4444@crumpleit.com\nMessage-Id: <09B70F7F-90FC-49EC-B854-3F0998B13443@landlessness.net>\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}.symbolize_keys
  end

end
