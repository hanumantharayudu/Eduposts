require 'csv'
class UploadCsvsController < ApplicationController

  def student_upload_csv
    @school = SchoolAdmin.find(params[:school_id])
    if params[:user]
      if params[:user][:csv]
        CSV.parse(params[:user][:csv].read) do |row|

          row = row.collect{|s| s.gsub("\"", "")}
          # row = row[0].to_s.split("\t").collect(&:strip)

          @student = User.create({
              :school_admin_id => @school.id,
              :email => row[0],
              :first_name => row[1],
              :last_name => row[2],
              :role => 'student',
              :password => 'ashok123',
              :password_confirmation => 'ashok123'
            })
          @student.generate_password_reset_code
          UserMailer.sent_student_invitation(@school,@student).deliver
        end

        flash[:notice] = "Uploading completed."
        render :update do |page|
          page.redirect_to school_path(current_school_admin)
        end
      end
    else
      render :update do |page|
        page.alert("Failed To Upload CSV")
      end
    end
  end

  def teacher_upload_csv
    @school = SchoolAdmin.find(params[:school_id])
    if params[:user]
      if params[:user][:csv]
        CSV.parse(params[:user][:csv].read) do |row|

          row = row.collect{|s| s.gsub("\"", "")}
          # row = row[0].to_s.split("\t").collect(&:strip)

          @teacher = User.create({
              :school_admin_id => @school.id,
              :email => row[0],
              :first_name => row[1],
              :last_name => row[2],
              :role => 'teacher',
              :password => 'ashok123',
              :password_confirmation => 'ashok123'
            })
          @teacher.generate_password_reset_code
          UserMailer.sent_teacher_invitation(@school,@teacher).deliver
        end

        flash[:notice] = "Uploading completed."
        render :update do |page|
          page.redirect_to school_path(current_school_admin)
        end
      end
    else
      render :update do |page|
        page.alert("Failed To Upload CSV")
      end
    end
  end

end
