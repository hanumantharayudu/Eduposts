class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_invitation(invitation)
    @invite = invitation
    mail(:to => invitation.email ,:from => 'k.ashok502@gmail.com', :subject => "Invitation to Join SmartQuotez")
  end

  def send_school_invitation(school)
    @school = school
    mail(:to => school.email ,:from => 'k.ashok502@gmail.com', :subject => "School #{@school.school_name} Created.")
  end

  def sent_student_invitation(school,student)
    @school = school
    @student = student
    mail(:to => student.email, :from => school.email, :subject => "HI")
  end

  def sent_teacher_invitation(school,teacher)
    @school = school
    @teacher = teacher
    mail(:to => teacher.email, :from => school.email, :subject => "HI")
  end

  def reply_post(user,post)
    @user = user
    @post = post
    mail(:to => user.email, :from => post.user.email,:reply_to => post.user.email, :subject => post.body)
  end

  def send_report(user,admin_email)
    @user = user
    @admin_email = admin_email
    mail(:to => @admin_email, :subject => "Report")
  end

  def contact(contact)
    @contact = contact
    mail(:to => "support@eduposts.com", :body => contact.email)
  end
end
