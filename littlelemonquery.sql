SHOW DATABASES;
INSERT INTO customers (customerid, fullname, email, contactnumber)
VALUES 
(1, 'John Doe', 'johndoe@example.com', '1234567890'),
(2, 'Jane Smith', 'janesmith@example.com', '0987654321'),
(3, 'Alice Johnson', 'alicej@example.com', '1122334455'),
(4, 'Bob Brown', 'bobbrown@example.com', '5566778899');

INSERT INTO menuitems (menuitemid, menuitemname, type, price, stock)
VALUES 
(1, 'Pasta Primavera', 'Main Course', 12.99, 'In Stock'),
(2, 'Caesar Salad', 'Starter', 7.99, 'In Stock'),
(3, 'Margherita Pizza', 'Main Course', 15.99, 'In Stock'),
(4, 'Tiramisu', 'Dessert', 5.99, 'Out of Stock'),
(5, 'Chicken Wings', 'Starter', 8.99, 'In Stock');

INSERT INTO menu (menuid, menuname, cuisine, menuitemid)
VALUES 
(1, 'Italian Classics', 'Italian', 1),
(2, 'Salads', 'Healthy', 2),
(3, 'Pizzas', 'Italian', 3),
(4, 'Desserts', 'Italian', 4),
(5, 'Snacks', 'American', 5);

INSERT INTO orders (orderid, orderdate, quantity, totalcost, menuid, customerid, staffid, orderdeliveryid)
VALUES 
(1, '2025-04-10', 3, 39.99, 1, 1, 1, 1),
(2, '2025-04-10', 1, 15.99, 2, 2, 2, 2),
(3, '2025-04-11', 2, 31.98, 3, 3, 3, 3),
(4, '2025-04-11', 5, 44.95, 1, 4, 4, 4), 
(5, '2025-04-12', 3, 26.97, 5, 2, 2, 5);

INSERT INTO staff (staffid, staffname, role, salary)
VALUES 
(1, 'James Miller', 'Chef', 2500.00),
(2, 'Sarah Lee', 'Waiter', 1800.00),
(3, 'Michael Brown', 'Chef', 2600.00),
(4, 'Emma Wilson', 'Manager', 3200.00);

INSERT INTO orderdeliverystatus (orderdeliveryid, status, deliverydate)
VALUES 
(1, 'Delivered', '2025-04-10'),
(2, 'Delivered', '2025-04-10'),
(3, 'Pending', '2025-04-12'),
(4, 'Delivered', '2025-04-11'),
(5, 'Pending', '2025-04-13');

INSERT INTO bookings (bookingid, bookingdate, tablenumber, customerid)
VALUES 
(1, '2025-04-10', 5, 1),
(2, '2025-04-11', 2, 2),
(3, '2025-04-12', 3, 3),
(4, '2025-04-13', 4, 4);


CREATE VIEW OrdersView AS
SELECT orderid, quantity, totalcost
FROM orders
WHERE quantity > 2;

SELECT * FROM OrdersView;

SELECT c.customerid, c.fullname, o.orderid, o.totalcost, m.menuname, mi.menuitemname
FROM customers c
JOIN orders o ON c.customerid = o.customerid
JOIN menu m ON o.menuid = m.menuid
JOIN menuitems mi ON m.menuitemid = mi.menuitemid
WHERE o.totalcost > 150
ORDER BY o.totalcost ASC;

SELECT m.menuname
FROM menu m
WHERE m.menuid = ANY (
    SELECT DISTINCT o.menuid
    FROM orders o
    WHERE o.quantity > 2
);


DELIMITER $$
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity) AS MaxOrderedQuantity FROM orders;
END $$
DELIMITER ;

CALL GetMaxQuantity();

DELIMITER $$
PREPARE GetOrderDetail FROM 
    'SELECT orderid, quantity, totalcost 
     FROM orders 
     WHERE customerid = ?';
DELIMITER ;

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

DELIMITER $$
CREATE PROCEDURE CancelOrder(IN orderID INT)
BEGIN
    DELETE FROM orders WHERE orderid = orderID;
    SELECT 'Order successfully deleted.' AS Message;
END $$
DELIMITER ;

CALL CancelOrder(1); 

PREPARE GetOrderDetail FROM 
'SELECT orderid, quantity, totalcost FROM orders WHERE customerid = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;
DEALLOCATE PREPARE GetOrderDetail;

SET SQL_SAFE_UPDATES = 0;
CALL CancelOrder(1);
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM bookings;

DELIMITER //
CREATE PROCEDURE CheckBooking (
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    DECLARE table_status VARCHAR(100);

    IF EXISTS (
        SELECT * FROM bookings 
        WHERE bookingdate = booking_date AND tablenumber = table_number
    ) THEN
        SET table_status = 'Table is already booked.';
    ELSE
        SET table_status = 'Table is available.';
    END IF;

    SELECT table_status AS Status;
END //
DELIMITER ;

CALL CheckBooking('2022-10-10', 5);



DELIMITER //
CREATE PROCEDURE AddValidBooking (
    IN booking_date DATE,
    IN table_number INT,
    IN customer_id INT
)
BEGIN
    DECLARE booking_exists INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO booking_exists
    FROM bookings
    WHERE bookingdate = booking_date AND tablenumber = table_number;

    IF booking_exists > 0 THEN
        ROLLBACK;
        SELECT 'Booking failed: Table is already booked.' AS Message;
    ELSE
        INSERT INTO bookings (bookingdate, tablenumber, customerid)
        VALUES (booking_date, table_number, customer_id);
        COMMIT;
        SELECT 'Booking confirmed.' AS Message;
    END IF;
END //
DELIMITER ;

ALTER TABLE bookings
MODIFY BookingID INT AUTO_INCREMENT;

CALL AddValidBooking('2022-10-10', 5, 4);  -- Should rollback
CALL AddValidBooking('2022-10-15', 5, 4);  -- Should commit


DELIMITER //
CREATE PROCEDURE AddBooking (
    IN p_booking_id INT,
    IN p_customer_id INT,
    IN p_booking_date DATE,
    IN p_table_number INT
)
BEGIN
    INSERT INTO bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (p_booking_id, p_customer_id, p_booking_date, p_table_number);
END //
DELIMITER ;
CALL AddBooking(NULL, 2, '2022-12-02', 3);

ALTER TABLE bookings 
MODIFY BookingID INT AUTO_INCREMENT ;

DELIMITER //
CREATE PROCEDURE UpdateBooking (
    IN p_booking_id INT,
    IN p_new_date DATE
)
BEGIN
    UPDATE bookings
    SET BookingDate = p_new_date
    WHERE BookingID = p_booking_id;
END //
DELIMITER ;
CALL UpdateBooking(3, '2022-12-05');

DELIMITER //
CREATE PROCEDURE CancelBooking (
    IN p_booking_id INT
)
BEGIN
    DELETE FROM bookings
    WHERE BookingID = p_booking_id;
END //
DELIMITER ;
CALL CancelBooking(4);

SHOW databases;

SELECT * FROM orders;