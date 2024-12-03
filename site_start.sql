CREATE DATABASE IF NOT EXISTS MassageSalon;
USE MassageSalon;

CREATE TABLE Clients (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL
);

CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL
);

CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomType ENUM('Обычный массаж', 'VIP массаж') NOT NULL,
    Status ENUM('Свободно', 'В брони', 'Занято') DEFAULT 'Свободно'
);

CREATE TABLE RoomStaff (
    RoomID INT,
    StaffID INT,
    PRIMARY KEY (RoomID, StaffID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE CASCADE
);

CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT,
    RoomID INT,
    BookingDateTime DATETIME NOT NULL,
    BookingStatus ENUM('Свободно', 'В брони', 'Занято') DEFAULT 'В брони',
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID) ON DELETE CASCADE,
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) ON DELETE CASCADE
);

DELIMITER //

CREATE TRIGGER SetRoomToBooked
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    UPDATE Rooms
    SET Status = 'В брони'
    WHERE RoomID = NEW.RoomID;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER FreeRoomOnBookingDelete
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
    UPDATE Rooms
    SET Status = 'Свободно'
    WHERE RoomID = OLD.RoomID;
END;
//

DELIMITER ;

INSERT INTO Clients (FullName, PhoneNumber, Email, Password)
VALUES 
('Артем Илюсь', '+79997776612', 'artem@admin.com', 'password123'),
('Антон Мурашов', '+79990000068', 'anton@admin.com', 'password777');

INSERT INTO Staff (FullName)
VALUES 
('Анна Иванова'),
('Ольга Петрова'),
('Мария Соколова'),
('Екатерина Смирнова'),
('Елена Волкова'),
('Наталия Кузнецова'),
('Ирина Медведева'),
('Алина Рожкова'),
('Лин Вэй'),
('Мэй Лин'),
('Юн Чэнь'),
('Сяо Ли');

INSERT INTO Rooms (RoomType)
VALUES 
('Обычный массаж'), ('Обычный массаж'), ('Обычный массаж'), ('Обычный массаж'),
('Обычный массаж'), ('Обычный массаж'), ('Обычный массаж'), ('Обычный массаж'),
('VIP массаж'), ('VIP массаж');

INSERT INTO RoomStaff (RoomID, StaffID)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4),
(5, 5), (6, 6), (7, 7), (8, 8),
(9, 9), (9, 10), (10, 11), (10, 12);

INSERT INTO Bookings (ClientID, RoomID, BookingDateTime, BookingStatus)
VALUES
(1, 1, '2024-12-03 10:00:00', 'В брони'),
(2, 9, '2024-12-03 12:00:00', 'В брони');
