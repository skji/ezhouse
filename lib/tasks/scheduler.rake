# coding: utf-8
desc "This task is called by the Heroku scheduler add-on"
task :update_tips => :environment do
  Tip.where(:available=>1).each do |tip|
    tip.update(:clicks=>tip.clicks+rand(10))
  end
end

desc "发送广告邮件"
task :mail_advrt => :environment do
  arr_of_arrs = CSV.read('lib/tasks/mails.csv', headers: true)

  arr_of_arrs.each do |data|
    arr_mail = data["mail"]
    arr_user = data["user"]

    Mail.deliver do
      to arr_mail
      from 'marketing@ehero.cc'
      subject "【全球首发】国内第一个中介大数据平台，让您对黑中介假房源说再见"
      content_type 'text/html;charset=UTF-8'
      body "易房好介是一个中介搜索平台，用科学的算法和多维度数据为您提供最准确的置业建议。<a href='http://ehero.cc/site/advert'>服务体验地址</a>"
    end

    puts arr_mail
  end
end
