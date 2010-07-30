require 'test_helper'

class DropBoxTest < ActiveSupport::TestCase
  
  setup do
    @send_grid_mail_thought = {"dkim"=>"none", "from"=>"Brian Mulloy <brian@mulloy.us>\n", "text"=>"this is another test.\n", "to"=>"brian+12344321@crumpleit.com\n", "subject"=>"Exercise\n", "attachments"=>"0", "headers"=>"Received: by 127.0.0.1 with SMTP id QpKzZ3u8wo\n        Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: from mail-pw0-f49.google.com (unknown [10.9.180.37])\n\tby mx1.send_grid.net (Postfix) with ESMTP id 22FD5464DD6\n\tfor <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: by pwj7 with SMTP id 7so450754pwj.8\n        for <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: by 10.142.229.13 with SMTP id b13mr1309896wfh.349.1280480624172;\n        Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: from [10.0.1.14] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id y16sm2238415wff.14.2010.07.30.02.03.42\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Fri, 30 Jul 2010 02:03:43 -0700 (PDT)\nFrom: Brian Mulloy <brian@mulloy.us>\nContent-Type: text/plain; charset=us-ascii\nContent-Transfer-Encoding: 7bit\nSubject: Exercise\nDate: Fri, 30 Jul 2010 02:03:41 -0700\nMessage-Id: <D77D0F07-E5D5-4396-92E7-712091A7A630@mulloy.us>\nTo: brian+4444@crumpleit.com\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}.symbolize_keys!
  end
  
  test 'find person and create new thought via drop box' do
    assert_equal 1, Person.count
    assert_equal 2, DropBox.count
    person = Person.first
    
    assert_not_nil @send_grid_mail_thought[:to]
    assert_equal projects(:exercise).name, @send_grid_mail_thought[:subject].strip!
    project = Project.find_by_name @send_grid_mail_thought[:subject]
    drop_box_name, drop_box_secret = DropBox.name_and_secret_from_email(@send_grid_mail_thought[:to])
    assert_equal drop_boxes(:brians_drop_box).name, drop_box_name
    assert_equal drop_boxes(:brians_drop_box).secret, drop_box_secret
    
    assert_equal person, DropBox.find_by_name_and_secret(drop_box_name, drop_box_secret).person

    assert_equal drop_box_name, person.drop_box.name
    assert_equal drop_box_secret, person.drop_box.secret

    thought = DropBox.new_thought @send_grid_mail_thought
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_not_nil thought.project
    assert_equal project, thought.project
    assert_equal @send_grid_mail_thought[:subject], thought.project.name
    assert @send_grid_mail_thought[:text].include?(thought.body)
    assert :drop_box, thought.state
    assert thought.new_record?
    assert thought.project.new_record?
  end
  
end
