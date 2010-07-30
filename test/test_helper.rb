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

  def read_fixture(action)
    IO.readlines(email_path(action))
  end
  
  def send_grid_mail
    {"dkim"=>"none", "from"=>"Brian Mulloy <brian@mulloy.us>\n", "text"=>"this is another test.\n", "to"=>"brian+12344321@crumpleit.com\n", "subject"=>"Exercise\n", "attachments"=>"0", "headers"=>"Received: by 127.0.0.1 with SMTP id QpKzZ3u8wo\n        Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: from mail-pw0-f49.google.com (unknown [10.9.180.37])\n\tby mx1.send_grid.net (Postfix) with ESMTP id 22FD5464DD6\n\tfor <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: by pwj7 with SMTP id 7so450754pwj.8\n        for <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: by 10.142.229.13 with SMTP id b13mr1309896wfh.349.1280480624172;\n        Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: from [10.0.1.14] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id y16sm2238415wff.14.2010.07.30.02.03.42\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Fri, 30 Jul 2010 02:03:43 -0700 (PDT)\nFrom: Brian Mulloy <brian@mulloy.us>\nContent-Type: text/plain; charset=us-ascii\nContent-Transfer-Encoding: 7bit\nSubject: Exercise\nDate: Fri, 30 Jul 2010 02:03:41 -0700\nMessage-Id: <D77D0F07-E5D5-4396-92E7-712091A7A630@mulloy.us>\nTo: brian+4444@crumpleit.com\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}.symbolize_keys!    
  end

end
