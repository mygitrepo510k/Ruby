class InvitationsMailer < ActionMailer::Base
  default from: "no_reply@medijean.com"
  layout "mailer"

  def patient_invitation( doctor_id, doctor_patient_id )
    @doctor = Doctor.find(doctor_id)
    @doctor_patient = DoctorPatient.find(doctor_patient_id)
    mail(to: @doctor_patient.email, subject: "#{@doctor.name} send you an invitation to MediJean!" ) do |format|
      format.html
    end
  end
end