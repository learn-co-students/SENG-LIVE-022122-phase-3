# - refactor your `initialize` method to use keyword arguments
# - add a `.all` method that returns all persisted appointments and create an `@@all` class variable to store them in
#   - add a `#save` method which persists the `appointment` receiving the method call to `@@all`. This method should return the appointment we call it on.
#   - add a `.create` method which accepts attributes as an argument, uses them to instantiate a new instance of the class, and invokes `.save` on the new instance
#   - add a `.by_doctor(doctor)` method which accepts a doctor name as an argument and returns all appointments with that doctor.
#   - add a `.by_patient(patient)` method which accepts a patient name as an argument and returns all appointments with that patient.

class Appointment

  @@all = []

  def self.all
    @@all
  end

  def self.create(attributes)
    self.new(attributes).save
  end

  def self.by_doctor(doctor)
    self.all.filter do |appointment|
      appointment.doctor == doctor
    end
  end

  def self.by_patient(patient)
    self.all.filter do |appointment|
      appointment.patient == patient
    end
  end

  attr_accessor :time, :doctor, :patient, :purpose, :notes, :canceled  

  def initialize(time:, doctor:, patient:, purpose:)
    @time = time
    @doctor = doctor
    @patient = patient
    @purpose = purpose
  end

  def save
    self.class.all << self
    self
  end

  def cancel
    @canceled = true
  end

  def print
    puts ""
    if self.canceled 
      puts "#{self.time} (canceled)".red
    else 
      puts self.time.light_green
    end
    puts "  Doctor: #{self.doctor}"
    puts "  Patient: #{self.patient}"
    puts "  Purpose: #{self.purpose}"
    puts "  Notes: #{self.notes}"
    puts ""
  end

  def valid?
    @time != "" && @doctor != "" && @patient != "" && @purpose != ""
  end
end

# After you've reworked the initialize method and defined your create method, 
# you can uncomment the lines below to use them as seed data for the application
# so you won't have to create new appointments each time you want to test your 
# application.


Appointment.create(
  time: "2:00 PM",
  doctor: "Dr. Drew",
  patient: "D",
  purpose: "Physical"
)

Appointment.create(
  time: "3:00 PM", 
  doctor: "Dr. Zhivago", 
  patient: "D", 
  purpose: "Checkup"
)

Appointment.create(
  time: "5:00 PM", 
  doctor: "Dr. Zhivago", 
  patient: "Laurence Fishburne", 
  purpose: "Checkup"
)

