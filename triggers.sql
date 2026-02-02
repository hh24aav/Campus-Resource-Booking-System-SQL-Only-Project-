/*
Triggers for Campus Resource Booking System
-------------------------------------------
This file contains triggers used to enforce business logic
that cannot be handled by constraints alone.

Status: Work in Progress
*/

-- ============================================
-- Trigger 1: Prevent invalid booking times
-- ============================================

CREATE OR REPLACE FUNCTION check_booking_time()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.end_time <= NEW.start_time THEN
        RAISE EXCEPTION 'End time must be after start time';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_booking_time
BEFORE INSERT OR UPDATE ON Bookings
FOR EACH ROW
EXECUTE FUNCTION check_booking_time();


-- ============================================
-- Trigger 2: Auto-cancel expired bookings
-- ============================================
-- TODO:
-- When the current time is past end_time,
-- automatically update booking status to 'cancelled'
-- This will likely require:
--  - a scheduled job (cron / pgAgent)
--  - or a trigger on SELECT (not supported directly)
-- Placeholder function below

-- CREATE OR REPLACE FUNCTION auto_cancel_expired_bookings()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- TODO: implement logic
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;


-- ============================================
-- Trigger 3: Prevent overlapping bookings
-- ============================================
-- TODO:
-- Prevent two bookings for the same resource
-- from overlapping in time.
--
-- Hint:
-- Check for existing bookings where:
-- NEW.start_time < existing.end_time
-- AND NEW.end_time > existing.start_time
-- AND status != 'cancelled'

-- CREATE OR REPLACE FUNCTION prevent_overlapping_bookings()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- TODO: overlap detection query
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;


-- ============================================
-- Trigger 4: Limit booking duration
-- ============================================
-- TODO:
-- Enforce a maximum booking duration (e.g., 2 hours)

-- CREATE OR REPLACE FUNCTION limit_booking_duration()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- TODO: check duration using interval comparison
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
