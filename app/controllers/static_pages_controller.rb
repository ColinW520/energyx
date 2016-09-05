class StaticPagesController < ApplicationController
  def home
    @posts = SocialPost.order('created_at DESC').limit(4)
  end

  def jobs

  end

  def calendar_feed
    start_date = Time.at(params[:start].to_i).to_date
    end_date = Time.at(params[:end].to_i).to_date
    time_zone_offset = 7 #fix MindBody lack of TZ support

    courses = MindBodySchedules.fetch_mindbody_schedule(:start_date => start_date, :end_date => end_date)
    response = []
    courses.each_with_index do |course,index|
      response << {
        :id => index.to_s,
        :title => "#{course.class_description.name}: #{course.staff.name}",
        :start => (course.start_date_time + time_zone_offset.hours).to_i.to_s,
        :end => (course.end_date_time + time_zone_offset.hours).to_i.to_s,
        :allDay => false
      }
    end

    render :json => response
  end

  def contact
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @spam_check = params[:spam_check]

    unless @spam_check.blank?
      flash[:alert] = 'We think this might be spam... Call us if you disagree!'
      redirect_to root_path and return
    end

    if @name.blank?
      flash[:danger] = 'Please enter your name before sending your message. Thank you.'
      redirect_to root_path
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:danger] = 'You must provide a valid email address before sending your message. Thank you.'
      redirect_to root_path
    elsif @message.blank? || @message.length < 10
      flash[:danger] = 'Your message is empty. Requires at least 10 characters. Nothing to send.'
      redirect_to root_path
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:danger] = "Please don't include links. Spammers do this. Thank you for your understanding."
      redirect_to root_path
    else
      ContactMailer.contact_message(@name, @email, @message).deliver
      flash[:success] = 'Your message was sent! We will get back to you shortly.'
      if @message == 'Intersted in a free class!'
        redirect_to 'https://clients.mindbodyonline.com/classic/home?studioid=226360'
      else
        redirect_to root_path
      end
    end
  end
end
