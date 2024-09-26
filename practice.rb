# 1.) create a new Class, User, that has the following attributes:
# - name
# - email
# - password

# 2.) create a new Class, Room, that has the following attributes:
# - name
# - description
# - users

# 3.) create a new Class, Message, that has the following attributes:
# - user
# - room
# - content

# 4.1) add a method to user so, user can enter to a room
# 4.2) user.enter_room(room)

# 5.1) add a method to user so, user can send a message to a room
# 5.2) user.send_message(room, message)
# 5.3) user.ackowledge_message(room, message)

# 6.1) add a method to a room, so it can broadcast a message to all users
# 6.2) room.broadcast(message)
# Class User

class User
  attr_accessor :name, :email, :password

 #ฟังก์ชัน initialize จะถูกเรียกตอนที่เราสร้าง User ใหม่
  def initialize(name, email, password) 
    @name, @email, @password = name, email, password
  end

#enter_room(room) ใช้สำหรับให้ผู้ใช้เข้าห้อง โดยจะเพิ่มผู้ใช้ลงในรายการผู้ใช้ของห้อง (room.users)
  def enter_room(room)
    room.users << self unless room.users.include?(self)
  end#self คือการอ้างอิงถึง ออบเจ็กต์ปัจจุบัน ที่กำลังเรียกใช้งานเมธอดหรืออยู่ภายในคลาสนั้นๆ

#ให้ผู้ใช้สามารถส่งข้อความไปยังห้องที่ระบุ โดยเราจะสร้างข้อความใหม่ (Message) แล้วส่งไปยังห้องด้วยการเรียก room.broadcast
  def send_message(room, content)
    room.broadcast(Message.new(self, room, content))
  end

#acknowledge_message ใช้แสดงข้อความเพื่อบอกว่า ผู้ใช้ได้รับทราบข้อความนี้
  def acknowledge_message(message)
    puts "#{name} acknowledged: #{message.content}"
  end
end

class Room
  attr_accessor :name, :description, :users

  def initialize(name, description)
    @name, @description, @users = name, description, []
  end

#broadcast ใช้เพื่อกระจายข้อความไปยังผู้ใช้ทั้งหมดในห้อง โดยจะแสดงว่าใครพูดอะไรในห้องนี้ (message.user.name) 
#แล้วส่งต่อข้อความไปยังผู้ใช้ทุกคน ยกเว้นคนที่เป็นคนส่งข้อความเอง
  def broadcast(message)
    puts "#{message.user.name} in #{name}: #{message.content}"
    users.each { |user| user.acknowledge_message(message) unless user == message.user }
  end#users.each จะวนลูปผ่านแต่ละองค์ประกอบในอาเรย์  
end #acknowledge_message ใช้เพื่อยืนยันว่าผู้ใช้ได้รับข้อความแล้ว

class Message
  attr_accessor :user, :room, :content

  def initialize(user, room, content)
    @user, @room, @content = user, room, content
  end
end

# ตัวอย่างการใช้งาน
#สร้างผู้ใช้ 2 คนคือ Nasaree  และ Nitkul
#สร้างห้องชื่อ "AIE312"
user1 = User.new("Nasaree ", "nasaree.yees@bumail.net", "password1584")
user2 = User.new("Nitkul", "Nitkul.keaw@bumail.net", "password456")
room1 = Room.new("AIE312", "AIE312 chat")

user1.enter_room(room1)
user2.enter_room(room1)
user1.send_message(room1, "Hello, everyone!, You did not pass AIE312. You received a grade of F.")