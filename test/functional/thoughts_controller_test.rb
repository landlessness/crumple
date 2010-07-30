require 'test_helper'

class ThoughtsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @thought = thoughts(:one)
    @person = people(:one)
    sign_in @person
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thought" do
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes
    end

    assert_redirected_to thought_path(assigns(:thought))
  end

  test "should create thought from email" do
    email_thought_attributes = {"dkim"=>"none", "from"=>"Brian Mulloy <brian@mulloy.us>\n", "text"=>"this is another test.\n", "to"=>"brian+4444@crumpleit.com\n", "subject"=>"Exercise\n", "attachments"=>"0", "headers"=>"Received: by 127.0.0.1 with SMTP id QpKzZ3u8wo\n        Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: from mail-pw0-f49.google.com (unknown [10.9.180.37])\n\tby mx1.sendgrid.net (Postfix) with ESMTP id 22FD5464DD6\n\tfor <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:45 -0700 (PDT)\nReceived: by pwj7 with SMTP id 7so450754pwj.8\n        for <brian+4444@crumpleit.com>; Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: by 10.142.229.13 with SMTP id b13mr1309896wfh.349.1280480624172;\n        Fri, 30 Jul 2010 02:03:44 -0700 (PDT)\nReceived: from [10.0.1.14] (c-67-180-8-127.hsd1.ca.comcast.net [67.180.8.127])\n        by mx.google.com with ESMTPS id y16sm2238415wff.14.2010.07.30.02.03.42\n        (version=TLSv1/SSLv3 cipher=RC4-MD5);\n        Fri, 30 Jul 2010 02:03:43 -0700 (PDT)\nFrom: Brian Mulloy <brian@mulloy.us>\nContent-Type: text/plain; charset=us-ascii\nContent-Transfer-Encoding: 7bit\nSubject: Exercise\nDate: Fri, 30 Jul 2010 02:03:41 -0700\nMessage-Id: <D77D0F07-E5D5-4396-92E7-712091A7A630@mulloy.us>\nTo: brian+4444@crumpleit.com\nMime-Version: 1.0 (Apple Message framework v1081)\nX-Mailer: Apple Mail (2.1081)\n"}
    
    assert_difference('Thought.count') do
      post :create, :thought => email_thought_attributes
    end
    
    assert_redirected_to thought_path(assigns(:thought))
  end

  test "should show thought" do
    get :show, :id => @thought.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @thought.to_param
    assert_response :success
  end

  test "should update thought" do
    put :update, :id => @thought.to_param, :thought => @thought.attributes
    assert_redirected_to thought_path(assigns(:thought))
  end

  test "should destroy thought" do
    assert_difference('Thought.count', -1) do
      delete :destroy, :id => @thought.to_param
    end

    assert_redirected_to thoughts_path
  end
end
