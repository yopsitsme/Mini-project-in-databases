--
-- PostgreSQL database dump
--

\restrict ewOQRInkricLeiyy7LqIUonJLUni2QMDlyl9kSxwkPcorsnW0xXeGUTAmQf4dzC

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-11 20:31:30

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 229 (class 1255 OID 17210)
-- Name: update_current_amount_on_delete(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_current_amount_on_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE group_of_sports 
    SET current_amount = current_amount - 1 
    WHERE id = OLD.group_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.update_current_amount_on_delete() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 17209)
-- Name: update_current_amount_on_insert(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_current_amount_on_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE group_of_sports 
    SET current_amount = current_amount + 1 
    WHERE id = NEW.group_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_current_amount_on_insert() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 17133)
-- Name: equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipment (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    amount integer
);


ALTER TABLE public.equipment OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17155)
-- Name: group_of_sports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_of_sports (
    id integer NOT NULL,
    level character varying(50),
    day_in_the_week character varying(20),
    start_time time without time zone,
    min_age integer DEFAULT 5,
    current_amount integer DEFAULT 0,
    teacher_id integer NOT NULL,
    sports_class_id integer NOT NULL
);


ALTER TABLE public.group_of_sports OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17126)
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location (
    id integer NOT NULL,
    location_name character varying(100) NOT NULL,
    city character varying(50),
    capacity integer
);


ALTER TABLE public.location OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17192)
-- Name: needs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.needs (
    equipment_id integer NOT NULL,
    sports_class_id integer NOT NULL,
    quantity_required integer
);


ALTER TABLE public.needs OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17175)
-- Name: participate_in; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participate_in (
    student_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.participate_in OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17097)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    birth_date date,
    email character varying(100),
    phone character varying(20)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17140)
-- Name: sports_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sports_class (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    capacity integer,
    cost numeric(10,2),
    duration integer DEFAULT 45,
    location_id integer NOT NULL,
    CONSTRAINT sports_class_capacity_check CHECK (((capacity >= 5) AND (capacity <= 20)))
);


ALTER TABLE public.sports_class OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17104)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    id integer NOT NULL,
    addres character varying(200)
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17115)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    id integer NOT NULL,
    salary numeric(10,2),
    hire_date date
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- TOC entry 5082 (class 0 OID 17133)
-- Dependencies: 223
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.equipment VALUES (1, 'First Aid Kit 1', 31);
INSERT INTO public.equipment VALUES (2, 'Hurdles 2', 42);
INSERT INTO public.equipment VALUES (3, 'Cones 3', 92);
INSERT INTO public.equipment VALUES (4, 'Volleyball 4', 26);
INSERT INTO public.equipment VALUES (5, 'Yoga Mat 5', 94);
INSERT INTO public.equipment VALUES (6, 'Medicine Ball 6', 17);
INSERT INTO public.equipment VALUES (7, 'Soccer Ball 7', 51);
INSERT INTO public.equipment VALUES (8, 'Stopwatch 8', 28);
INSERT INTO public.equipment VALUES (9, 'Medicine Ball 9', 59);
INSERT INTO public.equipment VALUES (10, 'Jump Rope 10', 21);
INSERT INTO public.equipment VALUES (11, 'Yoga Mat 11', 79);
INSERT INTO public.equipment VALUES (12, 'Tennis Racket 12', 23);
INSERT INTO public.equipment VALUES (13, 'Hurdles 13', 71);
INSERT INTO public.equipment VALUES (14, 'Stopwatch 14', 92);
INSERT INTO public.equipment VALUES (15, 'Jump Rope 15', 38);
INSERT INTO public.equipment VALUES (16, 'Medicine Ball 16', 83);
INSERT INTO public.equipment VALUES (17, 'Resistance Bands 17', 97);
INSERT INTO public.equipment VALUES (18, 'Yoga Mat 18', 89);
INSERT INTO public.equipment VALUES (19, 'Tennis Racket 19', 55);
INSERT INTO public.equipment VALUES (20, 'Water Bottles 20', 31);
INSERT INTO public.equipment VALUES (21, 'Soccer Ball 21', 60);
INSERT INTO public.equipment VALUES (22, 'Cones 22', 12);
INSERT INTO public.equipment VALUES (23, 'Resistance Bands 23', 100);
INSERT INTO public.equipment VALUES (24, 'Volleyball 24', 92);
INSERT INTO public.equipment VALUES (25, 'Yoga Mat 25', 79);
INSERT INTO public.equipment VALUES (26, 'Resistance Bands 26', 37);
INSERT INTO public.equipment VALUES (27, 'First Aid Kit 27', 10);
INSERT INTO public.equipment VALUES (28, 'Dumbbells 28', 67);
INSERT INTO public.equipment VALUES (29, 'Foam Roller 29', 58);
INSERT INTO public.equipment VALUES (30, 'Cones 30', 51);
INSERT INTO public.equipment VALUES (31, 'Foam Roller 31', 39);
INSERT INTO public.equipment VALUES (32, 'Resistance Bands 32', 77);
INSERT INTO public.equipment VALUES (33, 'Medicine Ball 33', 61);
INSERT INTO public.equipment VALUES (34, 'Resistance Bands 34', 67);
INSERT INTO public.equipment VALUES (35, 'Dumbbells 35', 11);
INSERT INTO public.equipment VALUES (36, 'Tennis Racket 36', 56);
INSERT INTO public.equipment VALUES (37, 'Resistance Bands 37', 43);
INSERT INTO public.equipment VALUES (38, 'Dumbbells 38', 24);
INSERT INTO public.equipment VALUES (39, 'Dumbbells 39', 45);
INSERT INTO public.equipment VALUES (40, 'Water Bottles 40', 60);
INSERT INTO public.equipment VALUES (41, 'Tennis Racket 41', 83);
INSERT INTO public.equipment VALUES (42, 'Foam Roller 42', 54);
INSERT INTO public.equipment VALUES (43, 'Tennis Racket 43', 41);
INSERT INTO public.equipment VALUES (44, 'Basketball 44', 55);
INSERT INTO public.equipment VALUES (45, 'Foam Roller 45', 54);
INSERT INTO public.equipment VALUES (46, 'Tennis Racket 46', 71);
INSERT INTO public.equipment VALUES (47, 'Hurdles 47', 67);
INSERT INTO public.equipment VALUES (48, 'Foam Roller 48', 86);
INSERT INTO public.equipment VALUES (49, 'Soccer Ball 49', 83);
INSERT INTO public.equipment VALUES (50, 'Resistance Bands 50', 35);
INSERT INTO public.equipment VALUES (51, 'Basketball 51', 86);
INSERT INTO public.equipment VALUES (52, 'Stopwatch 52', 95);
INSERT INTO public.equipment VALUES (53, 'Yoga Mat 53', 67);
INSERT INTO public.equipment VALUES (54, 'Yoga Mat 54', 67);
INSERT INTO public.equipment VALUES (55, 'Basketball 55', 87);
INSERT INTO public.equipment VALUES (56, 'Volleyball 56', 64);
INSERT INTO public.equipment VALUES (57, 'Water Bottles 57', 14);
INSERT INTO public.equipment VALUES (58, 'First Aid Kit 58', 23);
INSERT INTO public.equipment VALUES (59, 'Stopwatch 59', 58);
INSERT INTO public.equipment VALUES (60, 'Soccer Ball 60', 71);
INSERT INTO public.equipment VALUES (61, 'Foam Roller 61', 69);
INSERT INTO public.equipment VALUES (62, 'Foam Roller 62', 46);
INSERT INTO public.equipment VALUES (63, 'Cones 63', 56);
INSERT INTO public.equipment VALUES (64, 'Medicine Ball 64', 100);
INSERT INTO public.equipment VALUES (65, 'Soccer Ball 65', 13);
INSERT INTO public.equipment VALUES (66, 'Tennis Racket 66', 23);
INSERT INTO public.equipment VALUES (67, 'Volleyball 67', 64);
INSERT INTO public.equipment VALUES (68, 'Hurdles 68', 85);
INSERT INTO public.equipment VALUES (69, 'Yoga Mat 69', 67);
INSERT INTO public.equipment VALUES (70, 'Tennis Racket 70', 49);
INSERT INTO public.equipment VALUES (71, 'Soccer Ball 71', 57);
INSERT INTO public.equipment VALUES (72, 'Hurdles 72', 42);
INSERT INTO public.equipment VALUES (73, 'Jump Rope 73', 12);
INSERT INTO public.equipment VALUES (74, 'Tennis Racket 74', 83);
INSERT INTO public.equipment VALUES (75, 'Soccer Ball 75', 41);
INSERT INTO public.equipment VALUES (76, 'Cones 76', 56);
INSERT INTO public.equipment VALUES (77, 'First Aid Kit 77', 32);
INSERT INTO public.equipment VALUES (78, 'Soccer Ball 78', 87);
INSERT INTO public.equipment VALUES (79, 'Stopwatch 79', 34);
INSERT INTO public.equipment VALUES (80, 'Soccer Ball 80', 44);
INSERT INTO public.equipment VALUES (81, 'Yoga Mat 81', 68);
INSERT INTO public.equipment VALUES (82, 'Resistance Bands 82', 99);
INSERT INTO public.equipment VALUES (83, 'Volleyball 83', 77);
INSERT INTO public.equipment VALUES (84, 'Yoga Mat 84', 24);
INSERT INTO public.equipment VALUES (85, 'Foam Roller 85', 47);
INSERT INTO public.equipment VALUES (86, 'Hurdles 86', 14);
INSERT INTO public.equipment VALUES (87, 'Cones 87', 77);
INSERT INTO public.equipment VALUES (88, 'First Aid Kit 88', 95);
INSERT INTO public.equipment VALUES (89, 'Medicine Ball 89', 31);
INSERT INTO public.equipment VALUES (90, 'Cones 90', 55);
INSERT INTO public.equipment VALUES (91, 'Tennis Racket 91', 39);
INSERT INTO public.equipment VALUES (92, 'Tennis Racket 92', 61);
INSERT INTO public.equipment VALUES (93, 'First Aid Kit 93', 25);
INSERT INTO public.equipment VALUES (94, 'Dumbbells 94', 93);
INSERT INTO public.equipment VALUES (95, 'Stopwatch 95', 80);
INSERT INTO public.equipment VALUES (96, 'Foam Roller 96', 41);
INSERT INTO public.equipment VALUES (97, 'Soccer Ball 97', 38);
INSERT INTO public.equipment VALUES (98, 'Medicine Ball 98', 81);
INSERT INTO public.equipment VALUES (99, 'Tennis Racket 99', 42);
INSERT INTO public.equipment VALUES (100, 'Foam Roller 100', 30);
INSERT INTO public.equipment VALUES (101, 'Water Bottles 101', 63);
INSERT INTO public.equipment VALUES (102, 'Yoga Mat 102', 38);
INSERT INTO public.equipment VALUES (103, 'Dumbbells 103', 19);
INSERT INTO public.equipment VALUES (104, 'Resistance Bands 104', 33);
INSERT INTO public.equipment VALUES (105, 'Cones 105', 10);
INSERT INTO public.equipment VALUES (106, 'Volleyball 106', 19);
INSERT INTO public.equipment VALUES (107, 'Cones 107', 94);
INSERT INTO public.equipment VALUES (108, 'Hurdles 108', 92);
INSERT INTO public.equipment VALUES (109, 'Jump Rope 109', 26);
INSERT INTO public.equipment VALUES (110, 'Medicine Ball 110', 24);
INSERT INTO public.equipment VALUES (111, 'Water Bottles 111', 72);
INSERT INTO public.equipment VALUES (112, 'Cones 112', 50);
INSERT INTO public.equipment VALUES (113, 'First Aid Kit 113', 28);
INSERT INTO public.equipment VALUES (114, 'Basketball 114', 91);
INSERT INTO public.equipment VALUES (115, 'Foam Roller 115', 45);
INSERT INTO public.equipment VALUES (116, 'Foam Roller 116', 61);
INSERT INTO public.equipment VALUES (117, 'Soccer Ball 117', 22);
INSERT INTO public.equipment VALUES (118, 'Tennis Racket 118', 92);
INSERT INTO public.equipment VALUES (119, 'Dumbbells 119', 26);
INSERT INTO public.equipment VALUES (120, 'Medicine Ball 120', 43);
INSERT INTO public.equipment VALUES (121, 'Volleyball 121', 15);
INSERT INTO public.equipment VALUES (122, 'Tennis Racket 122', 47);
INSERT INTO public.equipment VALUES (123, 'Water Bottles 123', 93);
INSERT INTO public.equipment VALUES (124, 'Hurdles 124', 48);
INSERT INTO public.equipment VALUES (125, 'Foam Roller 125', 54);
INSERT INTO public.equipment VALUES (126, 'Foam Roller 126', 49);
INSERT INTO public.equipment VALUES (127, 'Water Bottles 127', 61);
INSERT INTO public.equipment VALUES (128, 'Resistance Bands 128', 18);
INSERT INTO public.equipment VALUES (129, 'First Aid Kit 129', 79);
INSERT INTO public.equipment VALUES (130, 'Basketball 130', 51);
INSERT INTO public.equipment VALUES (131, 'Cones 131', 67);
INSERT INTO public.equipment VALUES (132, 'Water Bottles 132', 10);
INSERT INTO public.equipment VALUES (133, 'Resistance Bands 133', 75);
INSERT INTO public.equipment VALUES (134, 'Soccer Ball 134', 95);
INSERT INTO public.equipment VALUES (135, 'Resistance Bands 135', 66);
INSERT INTO public.equipment VALUES (136, 'First Aid Kit 136', 36);
INSERT INTO public.equipment VALUES (137, 'Medicine Ball 137', 98);
INSERT INTO public.equipment VALUES (138, 'Yoga Mat 138', 86);
INSERT INTO public.equipment VALUES (139, 'Hurdles 139', 31);
INSERT INTO public.equipment VALUES (140, 'Tennis Racket 140', 25);
INSERT INTO public.equipment VALUES (141, 'Foam Roller 141', 65);
INSERT INTO public.equipment VALUES (142, 'Water Bottles 142', 60);
INSERT INTO public.equipment VALUES (143, 'Cones 143', 37);
INSERT INTO public.equipment VALUES (144, 'Dumbbells 144', 24);
INSERT INTO public.equipment VALUES (145, 'Cones 145', 86);
INSERT INTO public.equipment VALUES (146, 'Medicine Ball 146', 19);
INSERT INTO public.equipment VALUES (147, 'Resistance Bands 147', 84);
INSERT INTO public.equipment VALUES (148, 'Stopwatch 148', 96);
INSERT INTO public.equipment VALUES (149, 'Basketball 149', 54);
INSERT INTO public.equipment VALUES (150, 'Basketball 150', 41);
INSERT INTO public.equipment VALUES (151, 'Medicine Ball 151', 54);
INSERT INTO public.equipment VALUES (152, 'Dumbbells 152', 47);
INSERT INTO public.equipment VALUES (153, 'Medicine Ball 153', 57);
INSERT INTO public.equipment VALUES (154, 'Tennis Racket 154', 11);
INSERT INTO public.equipment VALUES (155, 'Resistance Bands 155', 20);
INSERT INTO public.equipment VALUES (156, 'Volleyball 156', 88);
INSERT INTO public.equipment VALUES (157, 'Soccer Ball 157', 50);
INSERT INTO public.equipment VALUES (158, 'Foam Roller 158', 20);
INSERT INTO public.equipment VALUES (159, 'Jump Rope 159', 88);
INSERT INTO public.equipment VALUES (160, 'Foam Roller 160', 100);
INSERT INTO public.equipment VALUES (161, 'Stopwatch 161', 44);
INSERT INTO public.equipment VALUES (162, 'Medicine Ball 162', 58);
INSERT INTO public.equipment VALUES (163, 'Jump Rope 163', 73);
INSERT INTO public.equipment VALUES (164, 'Volleyball 164', 22);
INSERT INTO public.equipment VALUES (165, 'Medicine Ball 165', 25);
INSERT INTO public.equipment VALUES (166, 'First Aid Kit 166', 23);
INSERT INTO public.equipment VALUES (167, 'Cones 167', 54);
INSERT INTO public.equipment VALUES (168, 'Dumbbells 168', 15);
INSERT INTO public.equipment VALUES (169, 'Dumbbells 169', 64);
INSERT INTO public.equipment VALUES (170, 'Resistance Bands 170', 94);
INSERT INTO public.equipment VALUES (171, 'Yoga Mat 171', 19);
INSERT INTO public.equipment VALUES (172, 'Jump Rope 172', 92);
INSERT INTO public.equipment VALUES (173, 'Dumbbells 173', 34);
INSERT INTO public.equipment VALUES (174, 'Tennis Racket 174', 13);
INSERT INTO public.equipment VALUES (175, 'Yoga Mat 175', 97);
INSERT INTO public.equipment VALUES (176, 'Volleyball 176', 74);
INSERT INTO public.equipment VALUES (177, 'Tennis Racket 177', 48);
INSERT INTO public.equipment VALUES (178, 'Dumbbells 178', 84);
INSERT INTO public.equipment VALUES (179, 'Dumbbells 179', 75);
INSERT INTO public.equipment VALUES (180, 'Volleyball 180', 66);
INSERT INTO public.equipment VALUES (181, 'Medicine Ball 181', 45);
INSERT INTO public.equipment VALUES (182, 'Medicine Ball 182', 45);
INSERT INTO public.equipment VALUES (183, 'Jump Rope 183', 68);
INSERT INTO public.equipment VALUES (184, 'Hurdles 184', 78);
INSERT INTO public.equipment VALUES (185, 'Dumbbells 185', 52);
INSERT INTO public.equipment VALUES (186, 'Yoga Mat 186', 21);
INSERT INTO public.equipment VALUES (187, 'Soccer Ball 187', 80);
INSERT INTO public.equipment VALUES (188, 'Foam Roller 188', 69);
INSERT INTO public.equipment VALUES (189, 'Tennis Racket 189', 42);
INSERT INTO public.equipment VALUES (190, 'Resistance Bands 190', 12);
INSERT INTO public.equipment VALUES (191, 'Foam Roller 191', 37);
INSERT INTO public.equipment VALUES (192, 'Yoga Mat 192', 80);
INSERT INTO public.equipment VALUES (193, 'Tennis Racket 193', 91);
INSERT INTO public.equipment VALUES (194, 'Resistance Bands 194', 60);
INSERT INTO public.equipment VALUES (195, 'Medicine Ball 195', 35);
INSERT INTO public.equipment VALUES (196, 'Yoga Mat 196', 63);
INSERT INTO public.equipment VALUES (197, 'Jump Rope 197', 63);
INSERT INTO public.equipment VALUES (198, 'Water Bottles 198', 98);
INSERT INTO public.equipment VALUES (199, 'Jump Rope 199', 14);
INSERT INTO public.equipment VALUES (200, 'Yoga Mat 200', 66);


--
-- TOC entry 5084 (class 0 OID 17155)
-- Dependencies: 225
-- Data for Name: group_of_sports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.group_of_sports VALUES (2, 'Intermediate', 'Sunday', '18:00:00', 11, 6, 187, 101);
INSERT INTO public.group_of_sports VALUES (52, 'Beginner', 'Tuesday', '08:00:00', 12, 3, 190, 161);
INSERT INTO public.group_of_sports VALUES (23, 'Advanced', 'Sunday', '17:00:00', 10, 4, 164, 21);
INSERT INTO public.group_of_sports VALUES (40, 'Beginner', 'Friday', '17:00:00', 6, 4, 155, 100);
INSERT INTO public.group_of_sports VALUES (121, 'Advanced', 'Monday', '08:00:00', 15, 3, 154, 97);
INSERT INTO public.group_of_sports VALUES (61, 'Beginner', 'Wednesday', '16:00:00', 12, 5, 164, 168);
INSERT INTO public.group_of_sports VALUES (104, 'Beginner', 'Friday', '15:00:00', 7, 5, 165, 47);
INSERT INTO public.group_of_sports VALUES (188, 'Advanced', 'Tuesday', '20:30:00', 14, 3, 194, 33);
INSERT INTO public.group_of_sports VALUES (105, 'Beginner', 'Wednesday', '20:30:00', 13, 7, 180, 147);
INSERT INTO public.group_of_sports VALUES (46, 'Intermediate', 'Monday', '11:30:00', 12, 2, 156, 140);
INSERT INTO public.group_of_sports VALUES (75, 'Beginner', 'Monday', '17:30:00', 10, 4, 184, 74);
INSERT INTO public.group_of_sports VALUES (44, 'Intermediate', 'Wednesday', '18:00:00', 14, 5, 153, 174);
INSERT INTO public.group_of_sports VALUES (35, 'Advanced', 'Friday', '17:30:00', 7, 3, 167, 183);
INSERT INTO public.group_of_sports VALUES (27, 'Intermediate', 'Monday', '08:00:00', 14, 3, 179, 44);
INSERT INTO public.group_of_sports VALUES (166, 'Intermediate', 'Friday', '09:00:00', 14, 5, 164, 51);
INSERT INTO public.group_of_sports VALUES (3, 'Beginner', 'Monday', '18:00:00', 14, 4, 174, 92);
INSERT INTO public.group_of_sports VALUES (22, 'Intermediate', 'Tuesday', '13:00:00', 14, 5, 191, 101);
INSERT INTO public.group_of_sports VALUES (45, 'Intermediate', 'Sunday', '14:00:00', 12, 4, 184, 184);
INSERT INTO public.group_of_sports VALUES (5, 'Beginner', 'Friday', '09:30:00', 12, 4, 159, 132);
INSERT INTO public.group_of_sports VALUES (173, 'Advanced', 'Sunday', '15:30:00', 14, 3, 151, 136);
INSERT INTO public.group_of_sports VALUES (51, 'Beginner', 'Thursday', '11:00:00', 13, 0, 152, 117);
INSERT INTO public.group_of_sports VALUES (63, 'Beginner', 'Sunday', '10:30:00', 10, 4, 151, 64);
INSERT INTO public.group_of_sports VALUES (113, 'Beginner', 'Monday', '10:00:00', 11, 6, 170, 94);
INSERT INTO public.group_of_sports VALUES (119, 'Intermediate', 'Wednesday', '13:00:00', 14, 6, 157, 195);
INSERT INTO public.group_of_sports VALUES (38, 'Advanced', 'Monday', '19:00:00', 9, 3, 171, 51);
INSERT INTO public.group_of_sports VALUES (128, 'Advanced', 'Wednesday', '18:00:00', 12, 4, 186, 118);
INSERT INTO public.group_of_sports VALUES (62, 'Advanced', 'Tuesday', '19:30:00', 12, 0, 190, 186);
INSERT INTO public.group_of_sports VALUES (21, 'Advanced', 'Monday', '17:00:00', 14, 4, 185, 159);
INSERT INTO public.group_of_sports VALUES (10, 'Beginner', 'Friday', '15:30:00', 15, 1, 172, 142);
INSERT INTO public.group_of_sports VALUES (29, 'Advanced', 'Tuesday', '14:00:00', 8, 2, 186, 76);
INSERT INTO public.group_of_sports VALUES (133, 'Beginner', 'Sunday', '08:00:00', 11, 4, 173, 164);
INSERT INTO public.group_of_sports VALUES (102, 'Beginner', 'Friday', '13:30:00', 14, 1, 199, 61);
INSERT INTO public.group_of_sports VALUES (152, 'Beginner', 'Sunday', '09:30:00', 6, 1, 173, 9);
INSERT INTO public.group_of_sports VALUES (131, 'Beginner', 'Thursday', '20:00:00', 15, 3, 154, 73);
INSERT INTO public.group_of_sports VALUES (106, 'Intermediate', 'Thursday', '14:00:00', 15, 2, 151, 189);
INSERT INTO public.group_of_sports VALUES (79, 'Advanced', 'Monday', '13:00:00', 11, 2, 190, 32);
INSERT INTO public.group_of_sports VALUES (20, 'Advanced', 'Wednesday', '20:30:00', 15, 1, 153, 88);
INSERT INTO public.group_of_sports VALUES (126, 'Advanced', 'Friday', '11:30:00', 5, 5, 159, 15);
INSERT INTO public.group_of_sports VALUES (120, 'Advanced', 'Wednesday', '20:30:00', 15, 2, 180, 189);
INSERT INTO public.group_of_sports VALUES (72, 'Intermediate', 'Monday', '12:30:00', 10, 4, 167, 55);
INSERT INTO public.group_of_sports VALUES (56, 'Beginner', 'Tuesday', '20:30:00', 11, 3, 184, 149);
INSERT INTO public.group_of_sports VALUES (82, 'Advanced', 'Monday', '15:00:00', 14, 4, 186, 134);
INSERT INTO public.group_of_sports VALUES (101, 'Intermediate', 'Wednesday', '20:30:00', 7, 0, 164, 43);
INSERT INTO public.group_of_sports VALUES (122, 'Intermediate', 'Tuesday', '19:30:00', 14, 9, 176, 3);
INSERT INTO public.group_of_sports VALUES (55, 'Beginner', 'Tuesday', '09:00:00', 5, 5, 159, 118);
INSERT INTO public.group_of_sports VALUES (151, 'Advanced', 'Sunday', '18:30:00', 13, 5, 165, 26);
INSERT INTO public.group_of_sports VALUES (169, 'Intermediate', 'Tuesday', '17:30:00', 5, 2, 186, 115);
INSERT INTO public.group_of_sports VALUES (117, 'Beginner', 'Wednesday', '16:30:00', 10, 0, 186, 156);
INSERT INTO public.group_of_sports VALUES (156, 'Intermediate', 'Sunday', '08:00:00', 7, 4, 161, 120);
INSERT INTO public.group_of_sports VALUES (187, 'Intermediate', 'Tuesday', '10:30:00', 9, 4, 185, 110);
INSERT INTO public.group_of_sports VALUES (71, 'Intermediate', 'Tuesday', '08:00:00', 5, 3, 174, 17);
INSERT INTO public.group_of_sports VALUES (49, 'Advanced', 'Friday', '16:00:00', 13, 6, 164, 81);
INSERT INTO public.group_of_sports VALUES (50, 'Advanced', 'Tuesday', '18:00:00', 11, 5, 184, 21);
INSERT INTO public.group_of_sports VALUES (179, 'Advanced', 'Tuesday', '09:00:00', 8, 7, 199, 126);
INSERT INTO public.group_of_sports VALUES (6, 'Advanced', 'Friday', '10:30:00', 9, 8, 163, 167);
INSERT INTO public.group_of_sports VALUES (178, 'Intermediate', 'Wednesday', '14:30:00', 9, 6, 198, 26);
INSERT INTO public.group_of_sports VALUES (99, 'Advanced', 'Tuesday', '15:00:00', 10, 2, 195, 97);
INSERT INTO public.group_of_sports VALUES (64, 'Advanced', 'Friday', '16:30:00', 6, 4, 189, 102);
INSERT INTO public.group_of_sports VALUES (143, 'Intermediate', 'Friday', '12:30:00', 7, 2, 188, 174);
INSERT INTO public.group_of_sports VALUES (18, 'Beginner', 'Tuesday', '15:00:00', 6, 3, 171, 67);
INSERT INTO public.group_of_sports VALUES (68, 'Advanced', 'Sunday', '18:00:00', 12, 4, 160, 141);
INSERT INTO public.group_of_sports VALUES (7, 'Beginner', 'Monday', '11:30:00', 9, 2, 160, 183);
INSERT INTO public.group_of_sports VALUES (8, 'Intermediate', 'Monday', '20:30:00', 15, 3, 199, 142);
INSERT INTO public.group_of_sports VALUES (109, 'Advanced', 'Tuesday', '15:30:00', 5, 3, 173, 155);
INSERT INTO public.group_of_sports VALUES (12, 'Intermediate', 'Thursday', '10:30:00', 6, 5, 192, 147);
INSERT INTO public.group_of_sports VALUES (47, 'Beginner', 'Sunday', '15:30:00', 15, 2, 168, 94);
INSERT INTO public.group_of_sports VALUES (129, 'Advanced', 'Sunday', '08:30:00', 9, 5, 173, 24);
INSERT INTO public.group_of_sports VALUES (66, 'Intermediate', 'Tuesday', '17:00:00', 14, 6, 199, 170);
INSERT INTO public.group_of_sports VALUES (171, 'Intermediate', 'Friday', '19:00:00', 15, 4, 166, 143);
INSERT INTO public.group_of_sports VALUES (59, 'Beginner', 'Wednesday', '11:30:00', 10, 8, 167, 126);
INSERT INTO public.group_of_sports VALUES (172, 'Advanced', 'Monday', '20:00:00', 14, 3, 156, 41);
INSERT INTO public.group_of_sports VALUES (33, 'Beginner', 'Monday', '15:00:00', 13, 8, 179, 141);
INSERT INTO public.group_of_sports VALUES (162, 'Beginner', 'Tuesday', '20:00:00', 11, 3, 168, 77);
INSERT INTO public.group_of_sports VALUES (186, 'Advanced', 'Tuesday', '08:30:00', 11, 5, 152, 74);
INSERT INTO public.group_of_sports VALUES (134, 'Beginner', 'Friday', '09:00:00', 5, 5, 161, 156);
INSERT INTO public.group_of_sports VALUES (28, 'Beginner', 'Monday', '19:00:00', 12, 7, 181, 46);
INSERT INTO public.group_of_sports VALUES (141, 'Beginner', 'Wednesday', '17:30:00', 11, 5, 154, 145);
INSERT INTO public.group_of_sports VALUES (198, 'Intermediate', 'Monday', '20:30:00', 6, 4, 173, 130);
INSERT INTO public.group_of_sports VALUES (89, 'Beginner', 'Wednesday', '15:30:00', 6, 7, 179, 80);
INSERT INTO public.group_of_sports VALUES (15, 'Intermediate', 'Monday', '16:30:00', 15, 9, 172, 139);
INSERT INTO public.group_of_sports VALUES (108, 'Intermediate', 'Sunday', '20:30:00', 11, 6, 180, 63);
INSERT INTO public.group_of_sports VALUES (177, 'Intermediate', 'Wednesday', '10:00:00', 11, 3, 185, 171);
INSERT INTO public.group_of_sports VALUES (14, 'Advanced', 'Thursday', '11:00:00', 8, 4, 155, 94);
INSERT INTO public.group_of_sports VALUES (190, 'Beginner', 'Tuesday', '20:30:00', 10, 1, 164, 91);
INSERT INTO public.group_of_sports VALUES (148, 'Intermediate', 'Tuesday', '11:00:00', 14, 5, 166, 101);
INSERT INTO public.group_of_sports VALUES (149, 'Intermediate', 'Friday', '16:30:00', 13, 3, 155, 13);
INSERT INTO public.group_of_sports VALUES (127, 'Advanced', 'Tuesday', '18:00:00', 15, 3, 165, 10);
INSERT INTO public.group_of_sports VALUES (170, 'Advanced', 'Thursday', '19:00:00', 9, 3, 184, 139);
INSERT INTO public.group_of_sports VALUES (157, 'Beginner', 'Friday', '20:30:00', 13, 3, 196, 44);
INSERT INTO public.group_of_sports VALUES (191, 'Advanced', 'Thursday', '12:30:00', 12, 5, 167, 70);
INSERT INTO public.group_of_sports VALUES (182, 'Beginner', 'Thursday', '18:30:00', 14, 1, 165, 8);
INSERT INTO public.group_of_sports VALUES (184, 'Beginner', 'Sunday', '12:30:00', 5, 7, 195, 166);
INSERT INTO public.group_of_sports VALUES (112, 'Intermediate', 'Friday', '20:00:00', 8, 4, 193, 184);
INSERT INTO public.group_of_sports VALUES (84, 'Beginner', 'Monday', '16:30:00', 8, 1, 184, 138);
INSERT INTO public.group_of_sports VALUES (37, 'Intermediate', 'Friday', '19:30:00', 11, 4, 174, 48);
INSERT INTO public.group_of_sports VALUES (19, 'Intermediate', 'Tuesday', '16:30:00', 13, 8, 199, 33);
INSERT INTO public.group_of_sports VALUES (195, 'Intermediate', 'Wednesday', '11:30:00', 8, 4, 185, 108);
INSERT INTO public.group_of_sports VALUES (165, 'Advanced', 'Friday', '09:30:00', 6, 5, 182, 87);
INSERT INTO public.group_of_sports VALUES (32, 'Advanced', 'Sunday', '15:00:00', 6, 4, 173, 31);
INSERT INTO public.group_of_sports VALUES (11, 'Beginner', 'Tuesday', '08:00:00', 13, 6, 170, 48);
INSERT INTO public.group_of_sports VALUES (69, 'Intermediate', 'Thursday', '08:00:00', 13, 6, 184, 58);
INSERT INTO public.group_of_sports VALUES (97, 'Advanced', 'Wednesday', '16:30:00', 12, 4, 162, 199);
INSERT INTO public.group_of_sports VALUES (142, 'Beginner', 'Thursday', '10:30:00', 15, 1, 178, 72);
INSERT INTO public.group_of_sports VALUES (87, 'Intermediate', 'Wednesday', '09:00:00', 5, 8, 185, 137);
INSERT INTO public.group_of_sports VALUES (73, 'Intermediate', 'Sunday', '19:00:00', 9, 6, 170, 42);
INSERT INTO public.group_of_sports VALUES (83, 'Intermediate', 'Wednesday', '20:30:00', 14, 4, 152, 19);
INSERT INTO public.group_of_sports VALUES (41, 'Intermediate', 'Sunday', '08:30:00', 11, 2, 164, 171);
INSERT INTO public.group_of_sports VALUES (74, 'Beginner', 'Wednesday', '17:00:00', 7, 5, 159, 120);
INSERT INTO public.group_of_sports VALUES (199, 'Beginner', 'Tuesday', '08:30:00', 14, 8, 162, 42);
INSERT INTO public.group_of_sports VALUES (91, 'Advanced', 'Thursday', '08:00:00', 10, 7, 178, 3);
INSERT INTO public.group_of_sports VALUES (189, 'Intermediate', 'Monday', '16:00:00', 15, 8, 151, 49);
INSERT INTO public.group_of_sports VALUES (42, 'Advanced', 'Friday', '15:30:00', 15, 6, 199, 165);
INSERT INTO public.group_of_sports VALUES (60, 'Beginner', 'Friday', '11:00:00', 8, 6, 173, 102);
INSERT INTO public.group_of_sports VALUES (24, 'Advanced', 'Friday', '15:00:00', 11, 7, 185, 40);
INSERT INTO public.group_of_sports VALUES (48, 'Intermediate', 'Sunday', '14:00:00', 7, 4, 191, 69);
INSERT INTO public.group_of_sports VALUES (153, 'Beginner', 'Wednesday', '13:30:00', 10, 6, 191, 132);
INSERT INTO public.group_of_sports VALUES (93, 'Beginner', 'Tuesday', '10:30:00', 14, 9, 181, 194);
INSERT INTO public.group_of_sports VALUES (103, 'Intermediate', 'Friday', '08:00:00', 10, 8, 168, 73);
INSERT INTO public.group_of_sports VALUES (154, 'Intermediate', 'Tuesday', '12:30:00', 15, 11, 186, 26);
INSERT INTO public.group_of_sports VALUES (158, 'Beginner', 'Tuesday', '09:00:00', 6, 1, 188, 136);
INSERT INTO public.group_of_sports VALUES (111, 'Advanced', 'Friday', '15:30:00', 7, 7, 170, 111);
INSERT INTO public.group_of_sports VALUES (78, 'Intermediate', 'Monday', '19:30:00', 14, 6, 191, 48);
INSERT INTO public.group_of_sports VALUES (76, 'Intermediate', 'Monday', '15:30:00', 6, 4, 163, 89);
INSERT INTO public.group_of_sports VALUES (146, 'Intermediate', 'Thursday', '20:30:00', 5, 6, 190, 162);
INSERT INTO public.group_of_sports VALUES (161, 'Beginner', 'Wednesday', '20:30:00', 6, 3, 168, 38);
INSERT INTO public.group_of_sports VALUES (1, 'Beginner', 'Wednesday', '09:30:00', 9, 2, 152, 79);
INSERT INTO public.group_of_sports VALUES (57, 'Beginner', 'Tuesday', '19:30:00', 5, 2, 198, 132);
INSERT INTO public.group_of_sports VALUES (81, 'Beginner', 'Monday', '08:30:00', 12, 3, 197, 166);
INSERT INTO public.group_of_sports VALUES (150, 'Beginner', 'Wednesday', '14:00:00', 12, 4, 196, 58);
INSERT INTO public.group_of_sports VALUES (114, 'Beginner', 'Thursday', '19:30:00', 12, 5, 196, 23);
INSERT INTO public.group_of_sports VALUES (176, 'Intermediate', 'Sunday', '14:30:00', 12, 3, 161, 145);
INSERT INTO public.group_of_sports VALUES (164, 'Advanced', 'Thursday', '12:00:00', 10, 3, 200, 94);
INSERT INTO public.group_of_sports VALUES (192, 'Advanced', 'Thursday', '17:00:00', 15, 5, 162, 189);
INSERT INTO public.group_of_sports VALUES (200, 'Intermediate', 'Thursday', '12:00:00', 7, 4, 190, 173);
INSERT INTO public.group_of_sports VALUES (98, 'Advanced', 'Thursday', '13:00:00', 5, 3, 186, 163);
INSERT INTO public.group_of_sports VALUES (16, 'Intermediate', 'Thursday', '19:00:00', 10, 6, 192, 110);
INSERT INTO public.group_of_sports VALUES (135, 'Intermediate', 'Monday', '17:00:00', 9, 3, 156, 46);
INSERT INTO public.group_of_sports VALUES (132, 'Intermediate', 'Monday', '10:00:00', 10, 8, 171, 194);
INSERT INTO public.group_of_sports VALUES (39, 'Intermediate', 'Sunday', '11:00:00', 7, 2, 196, 101);
INSERT INTO public.group_of_sports VALUES (167, 'Beginner', 'Tuesday', '13:30:00', 12, 3, 181, 52);
INSERT INTO public.group_of_sports VALUES (92, 'Advanced', 'Tuesday', '16:30:00', 10, 2, 169, 58);
INSERT INTO public.group_of_sports VALUES (67, 'Intermediate', 'Tuesday', '08:30:00', 10, 4, 189, 176);
INSERT INTO public.group_of_sports VALUES (25, 'Intermediate', 'Thursday', '17:30:00', 9, 2, 185, 109);
INSERT INTO public.group_of_sports VALUES (17, 'Beginner', 'Monday', '18:00:00', 6, 2, 160, 80);
INSERT INTO public.group_of_sports VALUES (194, 'Advanced', 'Sunday', '09:00:00', 8, 3, 158, 70);
INSERT INTO public.group_of_sports VALUES (94, 'Intermediate', 'Sunday', '08:30:00', 7, 3, 185, 178);
INSERT INTO public.group_of_sports VALUES (123, 'Beginner', 'Wednesday', '10:00:00', 14, 5, 196, 176);
INSERT INTO public.group_of_sports VALUES (88, 'Beginner', 'Thursday', '10:00:00', 13, 3, 155, 117);
INSERT INTO public.group_of_sports VALUES (136, 'Intermediate', 'Monday', '17:30:00', 6, 4, 161, 175);
INSERT INTO public.group_of_sports VALUES (183, 'Advanced', 'Tuesday', '11:30:00', 11, 3, 172, 100);
INSERT INTO public.group_of_sports VALUES (193, 'Intermediate', 'Sunday', '18:30:00', 9, 3, 189, 95);
INSERT INTO public.group_of_sports VALUES (140, 'Intermediate', 'Friday', '19:00:00', 8, 2, 167, 196);
INSERT INTO public.group_of_sports VALUES (116, 'Advanced', 'Sunday', '20:30:00', 15, 3, 173, 55);
INSERT INTO public.group_of_sports VALUES (77, 'Advanced', 'Sunday', '18:00:00', 13, 5, 153, 192);
INSERT INTO public.group_of_sports VALUES (100, 'Beginner', 'Friday', '17:30:00', 8, 1, 198, 113);
INSERT INTO public.group_of_sports VALUES (137, 'Intermediate', 'Thursday', '09:30:00', 5, 5, 175, 65);
INSERT INTO public.group_of_sports VALUES (43, 'Beginner', 'Friday', '16:30:00', 6, 3, 184, 13);
INSERT INTO public.group_of_sports VALUES (139, 'Beginner', 'Wednesday', '15:30:00', 13, 4, 188, 104);
INSERT INTO public.group_of_sports VALUES (145, 'Intermediate', 'Wednesday', '20:00:00', 13, 6, 180, 8);
INSERT INTO public.group_of_sports VALUES (34, 'Intermediate', 'Sunday', '20:00:00', 10, 4, 152, 133);
INSERT INTO public.group_of_sports VALUES (175, 'Advanced', 'Monday', '11:00:00', 8, 6, 195, 103);
INSERT INTO public.group_of_sports VALUES (9, 'Intermediate', 'Monday', '13:00:00', 10, 3, 155, 147);
INSERT INTO public.group_of_sports VALUES (58, 'Beginner', 'Wednesday', '08:30:00', 5, 5, 192, 90);
INSERT INTO public.group_of_sports VALUES (30, 'Advanced', 'Monday', '10:00:00', 10, 8, 159, 156);
INSERT INTO public.group_of_sports VALUES (168, 'Advanced', 'Thursday', '14:30:00', 10, 2, 159, 66);
INSERT INTO public.group_of_sports VALUES (125, 'Advanced', 'Thursday', '16:30:00', 11, 4, 191, 152);
INSERT INTO public.group_of_sports VALUES (138, 'Beginner', 'Wednesday', '20:00:00', 12, 4, 197, 149);
INSERT INTO public.group_of_sports VALUES (90, 'Beginner', 'Friday', '09:30:00', 13, 5, 153, 45);
INSERT INTO public.group_of_sports VALUES (196, 'Advanced', 'Monday', '17:30:00', 5, 3, 157, 87);
INSERT INTO public.group_of_sports VALUES (26, 'Beginner', 'Tuesday', '09:00:00', 5, 4, 197, 3);
INSERT INTO public.group_of_sports VALUES (53, 'Beginner', 'Friday', '13:00:00', 10, 2, 180, 180);
INSERT INTO public.group_of_sports VALUES (147, 'Intermediate', 'Thursday', '18:00:00', 9, 3, 199, 194);
INSERT INTO public.group_of_sports VALUES (54, 'Intermediate', 'Wednesday', '13:00:00', 6, 3, 159, 9);
INSERT INTO public.group_of_sports VALUES (185, 'Advanced', 'Wednesday', '13:00:00', 14, 3, 155, 58);
INSERT INTO public.group_of_sports VALUES (4, 'Beginner', 'Friday', '18:30:00', 11, 3, 159, 196);
INSERT INTO public.group_of_sports VALUES (124, 'Beginner', 'Friday', '11:30:00', 9, 2, 171, 100);
INSERT INTO public.group_of_sports VALUES (95, 'Beginner', 'Sunday', '18:00:00', 5, 4, 162, 67);
INSERT INTO public.group_of_sports VALUES (85, 'Intermediate', 'Sunday', '15:30:00', 14, 1, 173, 182);
INSERT INTO public.group_of_sports VALUES (80, 'Beginner', 'Monday', '13:00:00', 7, 5, 186, 177);
INSERT INTO public.group_of_sports VALUES (159, 'Intermediate', 'Monday', '12:30:00', 6, 4, 191, 60);
INSERT INTO public.group_of_sports VALUES (174, 'Advanced', 'Monday', '12:00:00', 13, 6, 168, 91);
INSERT INTO public.group_of_sports VALUES (160, 'Beginner', 'Monday', '19:00:00', 12, 3, 174, 136);
INSERT INTO public.group_of_sports VALUES (107, 'Advanced', 'Thursday', '12:00:00', 12, 1, 183, 81);
INSERT INTO public.group_of_sports VALUES (181, 'Beginner', 'Sunday', '16:30:00', 9, 2, 199, 20);
INSERT INTO public.group_of_sports VALUES (110, 'Intermediate', 'Monday', '10:00:00', 12, 3, 163, 120);
INSERT INTO public.group_of_sports VALUES (13, 'Intermediate', 'Sunday', '14:00:00', 12, 3, 191, 59);
INSERT INTO public.group_of_sports VALUES (115, 'Advanced', 'Wednesday', '08:00:00', 15, 4, 198, 184);
INSERT INTO public.group_of_sports VALUES (155, 'Advanced', 'Thursday', '11:30:00', 9, 8, 185, 106);
INSERT INTO public.group_of_sports VALUES (31, 'Beginner', 'Sunday', '12:30:00', 11, 6, 157, 31);
INSERT INTO public.group_of_sports VALUES (197, 'Beginner', 'Monday', '15:30:00', 10, 7, 199, 185);
INSERT INTO public.group_of_sports VALUES (86, 'Advanced', 'Monday', '19:30:00', 14, 5, 161, 159);
INSERT INTO public.group_of_sports VALUES (180, 'Advanced', 'Friday', '11:30:00', 9, 4, 152, 178);
INSERT INTO public.group_of_sports VALUES (36, 'Intermediate', 'Friday', '10:00:00', 12, 5, 190, 138);
INSERT INTO public.group_of_sports VALUES (163, 'Intermediate', 'Monday', '09:30:00', 11, 3, 189, 168);
INSERT INTO public.group_of_sports VALUES (130, 'Beginner', 'Thursday', '20:00:00', 13, 6, 164, 17);
INSERT INTO public.group_of_sports VALUES (65, 'Advanced', 'Tuesday', '12:30:00', 7, 6, 191, 100);
INSERT INTO public.group_of_sports VALUES (70, 'Beginner', 'Friday', '20:30:00', 11, 5, 169, 13);
INSERT INTO public.group_of_sports VALUES (118, 'Beginner', 'Monday', '08:00:00', 11, 7, 171, 3);
INSERT INTO public.group_of_sports VALUES (144, 'Intermediate', 'Wednesday', '13:00:00', 7, 7, 193, 60);
INSERT INTO public.group_of_sports VALUES (96, 'Beginner', 'Tuesday', '18:00:00', 10, 6, 196, 111);


--
-- TOC entry 5081 (class 0 OID 17126)
-- Dependencies: 222
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.location VALUES (1, 'Athletic Complex 1', 'Jerusalem', 341);
INSERT INTO public.location VALUES (2, 'Wellness Center 2', 'Petah Tikva', 120);
INSERT INTO public.location VALUES (3, 'Sports Center 3', 'Ramat Gan', 435);
INSERT INTO public.location VALUES (4, 'Wellness Center 4', 'Petah Tikva', 321);
INSERT INTO public.location VALUES (5, 'Sport Arena 5', 'Netanya', 186);
INSERT INTO public.location VALUES (6, 'Training Facility 6', 'Holon', 394);
INSERT INTO public.location VALUES (7, 'Recreation Center 7', 'Holon', 201);
INSERT INTO public.location VALUES (8, 'Recreation Center 8', 'Rishon LeZion', 222);
INSERT INTO public.location VALUES (9, 'Community Hall 9', 'Rishon LeZion', 340);
INSERT INTO public.location VALUES (10, 'Wellness Center 10', 'Tel Aviv', 188);
INSERT INTO public.location VALUES (11, 'Wellness Center 11', 'Tel Aviv', 76);
INSERT INTO public.location VALUES (12, 'Wellness Center 12', 'Petah Tikva', 343);
INSERT INTO public.location VALUES (13, 'Wellness Center 13', 'Netanya', 466);
INSERT INTO public.location VALUES (14, 'Community Hall 14', 'Beersheba', 434);
INSERT INTO public.location VALUES (15, 'Wellness Center 15', 'Netanya', 370);
INSERT INTO public.location VALUES (16, 'Recreation Center 16', 'Ramat Gan', 98);
INSERT INTO public.location VALUES (17, 'Recreation Center 17', 'Ramat Gan', 241);
INSERT INTO public.location VALUES (18, 'Athletic Complex 18', 'Holon', 459);
INSERT INTO public.location VALUES (19, 'Sports Center 19', 'Ramat Gan', 298);
INSERT INTO public.location VALUES (20, 'Wellness Center 20', 'Ramat Gan', 422);
INSERT INTO public.location VALUES (21, 'Wellness Center 21', 'Ashdod', 215);
INSERT INTO public.location VALUES (22, 'Athletic Complex 22', 'Tel Aviv', 385);
INSERT INTO public.location VALUES (23, 'Sports Center 23', 'Beersheba', 362);
INSERT INTO public.location VALUES (24, 'Fitness Hub 24', 'Holon', 350);
INSERT INTO public.location VALUES (25, 'Training Facility 25', 'Rishon LeZion', 481);
INSERT INTO public.location VALUES (26, 'Wellness Center 26', 'Beersheba', 179);
INSERT INTO public.location VALUES (27, 'Community Hall 27', 'Petah Tikva', 174);
INSERT INTO public.location VALUES (28, 'Sports Center 28', 'Tel Aviv', 482);
INSERT INTO public.location VALUES (29, 'Training Facility 29', 'Netanya', 254);
INSERT INTO public.location VALUES (30, 'Wellness Center 30', 'Tel Aviv', 190);
INSERT INTO public.location VALUES (31, 'Recreation Center 31', 'Holon', 335);
INSERT INTO public.location VALUES (32, 'Training Facility 32', 'Ashdod', 499);
INSERT INTO public.location VALUES (33, 'Training Facility 33', 'Holon', 405);
INSERT INTO public.location VALUES (34, 'Athletic Complex 34', 'Netanya', 326);
INSERT INTO public.location VALUES (35, 'Recreation Center 35', 'Jerusalem', 477);
INSERT INTO public.location VALUES (36, 'Sport Arena 36', 'Netanya', 90);
INSERT INTO public.location VALUES (37, 'Recreation Center 37', 'Jerusalem', 331);
INSERT INTO public.location VALUES (38, 'Recreation Center 38', 'Netanya', 288);
INSERT INTO public.location VALUES (39, 'Training Facility 39', 'Rishon LeZion', 129);
INSERT INTO public.location VALUES (40, 'Recreation Center 40', 'Holon', 98);
INSERT INTO public.location VALUES (41, 'Fitness Hub 41', 'Ashdod', 243);
INSERT INTO public.location VALUES (42, 'Training Facility 42', 'Beersheba', 204);
INSERT INTO public.location VALUES (43, 'Recreation Center 43', 'Petah Tikva', 154);
INSERT INTO public.location VALUES (44, 'Fitness Hub 44', 'Holon', 495);
INSERT INTO public.location VALUES (45, 'Fitness Hub 45', 'Beersheba', 97);
INSERT INTO public.location VALUES (46, 'Wellness Center 46', 'Ramat Gan', 326);
INSERT INTO public.location VALUES (47, 'Sports Center 47', 'Ashdod', 288);
INSERT INTO public.location VALUES (48, 'Fitness Hub 48', 'Tel Aviv', 438);
INSERT INTO public.location VALUES (49, 'Community Hall 49', 'Netanya', 58);
INSERT INTO public.location VALUES (50, 'Community Hall 50', 'Netanya', 374);
INSERT INTO public.location VALUES (51, 'Community Hall 51', 'Jerusalem', 139);
INSERT INTO public.location VALUES (52, 'Wellness Center 52', 'Jerusalem', 375);
INSERT INTO public.location VALUES (53, 'Community Hall 53', 'Holon', 103);
INSERT INTO public.location VALUES (54, 'Recreation Center 54', 'Beersheba', 153);
INSERT INTO public.location VALUES (55, 'Wellness Center 55', 'Jerusalem', 205);
INSERT INTO public.location VALUES (56, 'Sports Center 56', 'Haifa', 352);
INSERT INTO public.location VALUES (57, 'Recreation Center 57', 'Netanya', 53);
INSERT INTO public.location VALUES (58, 'Sports Center 58', 'Tel Aviv', 273);
INSERT INTO public.location VALUES (59, 'Recreation Center 59', 'Rishon LeZion', 86);
INSERT INTO public.location VALUES (60, 'Community Hall 60', 'Rishon LeZion', 232);
INSERT INTO public.location VALUES (61, 'Sport Arena 61', 'Ashdod', 392);
INSERT INTO public.location VALUES (62, 'Training Facility 62', 'Tel Aviv', 83);
INSERT INTO public.location VALUES (63, 'Community Hall 63', 'Petah Tikva', 319);
INSERT INTO public.location VALUES (64, 'Sport Arena 64', 'Holon', 172);
INSERT INTO public.location VALUES (65, 'Sport Arena 65', 'Jerusalem', 411);
INSERT INTO public.location VALUES (66, 'Community Hall 66', 'Rishon LeZion', 275);
INSERT INTO public.location VALUES (67, 'Fitness Hub 67', 'Ashdod', 416);
INSERT INTO public.location VALUES (68, 'Sport Arena 68', 'Jerusalem', 271);
INSERT INTO public.location VALUES (69, 'Recreation Center 69', 'Holon', 154);
INSERT INTO public.location VALUES (70, 'Sports Center 70', 'Ashdod', 443);
INSERT INTO public.location VALUES (71, 'Community Hall 71', 'Petah Tikva', 489);
INSERT INTO public.location VALUES (72, 'Sport Arena 72', 'Beersheba', 247);
INSERT INTO public.location VALUES (73, 'Training Facility 73', 'Jerusalem', 416);
INSERT INTO public.location VALUES (74, 'Wellness Center 74', 'Jerusalem', 267);
INSERT INTO public.location VALUES (75, 'Community Hall 75', 'Tel Aviv', 440);
INSERT INTO public.location VALUES (76, 'Recreation Center 76', 'Petah Tikva', 148);
INSERT INTO public.location VALUES (77, 'Fitness Hub 77', 'Rishon LeZion', 202);
INSERT INTO public.location VALUES (78, 'Sport Arena 78', 'Rishon LeZion', 72);
INSERT INTO public.location VALUES (79, 'Sport Arena 79', 'Netanya', 185);
INSERT INTO public.location VALUES (80, 'Fitness Hub 80', 'Petah Tikva', 292);
INSERT INTO public.location VALUES (81, 'Sport Arena 81', 'Netanya', 358);
INSERT INTO public.location VALUES (82, 'Athletic Complex 82', 'Petah Tikva', 483);
INSERT INTO public.location VALUES (83, 'Recreation Center 83', 'Beersheba', 327);
INSERT INTO public.location VALUES (84, 'Athletic Complex 84', 'Jerusalem', 261);
INSERT INTO public.location VALUES (85, 'Sports Center 85', 'Beersheba', 478);
INSERT INTO public.location VALUES (86, 'Sport Arena 86', 'Jerusalem', 289);
INSERT INTO public.location VALUES (87, 'Athletic Complex 87', 'Haifa', 80);
INSERT INTO public.location VALUES (88, 'Fitness Hub 88', 'Beersheba', 494);
INSERT INTO public.location VALUES (89, 'Athletic Complex 89', 'Holon', 241);
INSERT INTO public.location VALUES (90, 'Training Facility 90', 'Haifa', 414);
INSERT INTO public.location VALUES (91, 'Wellness Center 91', 'Ramat Gan', 100);
INSERT INTO public.location VALUES (92, 'Wellness Center 92', 'Petah Tikva', 352);
INSERT INTO public.location VALUES (93, 'Training Facility 93', 'Jerusalem', 431);
INSERT INTO public.location VALUES (94, 'Sport Arena 94', 'Jerusalem', 430);
INSERT INTO public.location VALUES (95, 'Training Facility 95', 'Petah Tikva', 247);
INSERT INTO public.location VALUES (96, 'Wellness Center 96', 'Tel Aviv', 266);
INSERT INTO public.location VALUES (97, 'Sport Arena 97', 'Beersheba', 389);
INSERT INTO public.location VALUES (98, 'Sports Center 98', 'Netanya', 373);
INSERT INTO public.location VALUES (99, 'Sports Center 99', 'Haifa', 319);
INSERT INTO public.location VALUES (100, 'Sport Arena 100', 'Petah Tikva', 74);
INSERT INTO public.location VALUES (101, 'Recreation Center 101', 'Haifa', 110);
INSERT INTO public.location VALUES (102, 'Athletic Complex 102', 'Beersheba', 420);
INSERT INTO public.location VALUES (103, 'Recreation Center 103', 'Holon', 271);
INSERT INTO public.location VALUES (104, 'Wellness Center 104', 'Beersheba', 318);
INSERT INTO public.location VALUES (105, 'Training Facility 105', 'Ashdod', 352);
INSERT INTO public.location VALUES (106, 'Fitness Hub 106', 'Haifa', 382);
INSERT INTO public.location VALUES (107, 'Fitness Hub 107', 'Ashdod', 425);
INSERT INTO public.location VALUES (108, 'Recreation Center 108', 'Petah Tikva', 287);
INSERT INTO public.location VALUES (109, 'Fitness Hub 109', 'Ramat Gan', 301);
INSERT INTO public.location VALUES (110, 'Fitness Hub 110', 'Petah Tikva', 402);
INSERT INTO public.location VALUES (111, 'Community Hall 111', 'Tel Aviv', 329);
INSERT INTO public.location VALUES (112, 'Sport Arena 112', 'Ramat Gan', 185);
INSERT INTO public.location VALUES (113, 'Recreation Center 113', 'Jerusalem', 173);
INSERT INTO public.location VALUES (114, 'Sport Arena 114', 'Beersheba', 371);
INSERT INTO public.location VALUES (115, 'Recreation Center 115', 'Jerusalem', 287);
INSERT INTO public.location VALUES (116, 'Sports Center 116', 'Netanya', 139);
INSERT INTO public.location VALUES (117, 'Sports Center 117', 'Beersheba', 429);
INSERT INTO public.location VALUES (118, 'Sport Arena 118', 'Holon', 325);
INSERT INTO public.location VALUES (119, 'Recreation Center 119', 'Tel Aviv', 165);
INSERT INTO public.location VALUES (120, 'Sports Center 120', 'Haifa', 127);
INSERT INTO public.location VALUES (121, 'Community Hall 121', 'Holon', 393);
INSERT INTO public.location VALUES (122, 'Training Facility 122', 'Ramat Gan', 254);
INSERT INTO public.location VALUES (123, 'Athletic Complex 123', 'Tel Aviv', 423);
INSERT INTO public.location VALUES (124, 'Fitness Hub 124', 'Rishon LeZion', 200);
INSERT INTO public.location VALUES (125, 'Community Hall 125', 'Tel Aviv', 475);
INSERT INTO public.location VALUES (126, 'Wellness Center 126', 'Rishon LeZion', 135);
INSERT INTO public.location VALUES (127, 'Fitness Hub 127', 'Ramat Gan', 253);
INSERT INTO public.location VALUES (128, 'Sports Center 128', 'Haifa', 369);
INSERT INTO public.location VALUES (129, 'Wellness Center 129', 'Tel Aviv', 110);
INSERT INTO public.location VALUES (130, 'Recreation Center 130', 'Netanya', 329);
INSERT INTO public.location VALUES (131, 'Wellness Center 131', 'Beersheba', 371);
INSERT INTO public.location VALUES (132, 'Fitness Hub 132', 'Petah Tikva', 446);
INSERT INTO public.location VALUES (133, 'Sports Center 133', 'Petah Tikva', 341);
INSERT INTO public.location VALUES (134, 'Community Hall 134', 'Ashdod', 402);
INSERT INTO public.location VALUES (135, 'Sport Arena 135', 'Petah Tikva', 161);
INSERT INTO public.location VALUES (136, 'Training Facility 136', 'Jerusalem', 143);
INSERT INTO public.location VALUES (137, 'Sports Center 137', 'Jerusalem', 435);
INSERT INTO public.location VALUES (138, 'Training Facility 138', 'Jerusalem', 344);
INSERT INTO public.location VALUES (139, 'Fitness Hub 139', 'Rishon LeZion', 268);
INSERT INTO public.location VALUES (140, 'Training Facility 140', 'Ramat Gan', 291);
INSERT INTO public.location VALUES (141, 'Fitness Hub 141', 'Ramat Gan', 438);
INSERT INTO public.location VALUES (142, 'Recreation Center 142', 'Haifa', 158);
INSERT INTO public.location VALUES (143, 'Sports Center 143', 'Ramat Gan', 63);
INSERT INTO public.location VALUES (144, 'Training Facility 144', 'Netanya', 58);
INSERT INTO public.location VALUES (145, 'Sport Arena 145', 'Netanya', 429);
INSERT INTO public.location VALUES (146, 'Wellness Center 146', 'Tel Aviv', 478);
INSERT INTO public.location VALUES (147, 'Sports Center 147', 'Haifa', 79);
INSERT INTO public.location VALUES (148, 'Athletic Complex 148', 'Petah Tikva', 290);
INSERT INTO public.location VALUES (149, 'Athletic Complex 149', 'Beersheba', 388);
INSERT INTO public.location VALUES (150, 'Athletic Complex 150', 'Ramat Gan', 495);
INSERT INTO public.location VALUES (151, 'Wellness Center 151', 'Haifa', 107);
INSERT INTO public.location VALUES (152, 'Sport Arena 152', 'Tel Aviv', 185);
INSERT INTO public.location VALUES (153, 'Sport Arena 153', 'Ashdod', 268);
INSERT INTO public.location VALUES (154, 'Wellness Center 154', 'Rishon LeZion', 365);
INSERT INTO public.location VALUES (155, 'Community Hall 155', 'Beersheba', 87);
INSERT INTO public.location VALUES (156, 'Recreation Center 156', 'Tel Aviv', 385);
INSERT INTO public.location VALUES (157, 'Wellness Center 157', 'Netanya', 422);
INSERT INTO public.location VALUES (158, 'Sports Center 158', 'Tel Aviv', 91);
INSERT INTO public.location VALUES (159, 'Community Hall 159', 'Tel Aviv', 275);
INSERT INTO public.location VALUES (160, 'Sport Arena 160', 'Jerusalem', 295);
INSERT INTO public.location VALUES (161, 'Fitness Hub 161', 'Petah Tikva', 216);
INSERT INTO public.location VALUES (162, 'Community Hall 162', 'Jerusalem', 399);
INSERT INTO public.location VALUES (163, 'Sports Center 163', 'Jerusalem', 73);
INSERT INTO public.location VALUES (164, 'Recreation Center 164', 'Rishon LeZion', 492);
INSERT INTO public.location VALUES (165, 'Wellness Center 165', 'Rishon LeZion', 219);
INSERT INTO public.location VALUES (166, 'Sport Arena 166', 'Netanya', 54);
INSERT INTO public.location VALUES (167, 'Sport Arena 167', 'Holon', 469);
INSERT INTO public.location VALUES (168, 'Training Facility 168', 'Rishon LeZion', 116);
INSERT INTO public.location VALUES (169, 'Fitness Hub 169', 'Netanya', 98);
INSERT INTO public.location VALUES (170, 'Sports Center 170', 'Beersheba', 268);
INSERT INTO public.location VALUES (171, 'Sports Center 171', 'Haifa', 352);
INSERT INTO public.location VALUES (172, 'Sports Center 172', 'Petah Tikva', 115);
INSERT INTO public.location VALUES (173, 'Sports Center 173', 'Netanya', 304);
INSERT INTO public.location VALUES (174, 'Wellness Center 174', 'Ashdod', 242);
INSERT INTO public.location VALUES (175, 'Sport Arena 175', 'Jerusalem', 304);
INSERT INTO public.location VALUES (176, 'Sports Center 176', 'Rishon LeZion', 455);
INSERT INTO public.location VALUES (177, 'Training Facility 177', 'Beersheba', 457);
INSERT INTO public.location VALUES (178, 'Wellness Center 178', 'Ashdod', 273);
INSERT INTO public.location VALUES (179, 'Sport Arena 179', 'Ramat Gan', 471);
INSERT INTO public.location VALUES (180, 'Athletic Complex 180', 'Petah Tikva', 210);
INSERT INTO public.location VALUES (181, 'Wellness Center 181', 'Rishon LeZion', 411);
INSERT INTO public.location VALUES (182, 'Recreation Center 182', 'Rishon LeZion', 185);
INSERT INTO public.location VALUES (183, 'Recreation Center 183', 'Ramat Gan', 392);
INSERT INTO public.location VALUES (184, 'Fitness Hub 184', 'Tel Aviv', 461);
INSERT INTO public.location VALUES (185, 'Training Facility 185', 'Haifa', 279);
INSERT INTO public.location VALUES (186, 'Community Hall 186', 'Holon', 269);
INSERT INTO public.location VALUES (187, 'Training Facility 187', 'Ramat Gan', 434);
INSERT INTO public.location VALUES (188, 'Wellness Center 188', 'Ramat Gan', 316);
INSERT INTO public.location VALUES (189, 'Athletic Complex 189', 'Jerusalem', 407);
INSERT INTO public.location VALUES (190, 'Fitness Hub 190', 'Jerusalem', 122);
INSERT INTO public.location VALUES (191, 'Wellness Center 191', 'Haifa', 342);
INSERT INTO public.location VALUES (192, 'Recreation Center 192', 'Ramat Gan', 239);
INSERT INTO public.location VALUES (193, 'Recreation Center 193', 'Netanya', 183);
INSERT INTO public.location VALUES (194, 'Recreation Center 194', 'Holon', 218);
INSERT INTO public.location VALUES (195, 'Athletic Complex 195', 'Rishon LeZion', 388);
INSERT INTO public.location VALUES (196, 'Recreation Center 196', 'Ramat Gan', 217);
INSERT INTO public.location VALUES (197, 'Community Hall 197', 'Netanya', 174);
INSERT INTO public.location VALUES (198, 'Sport Arena 198', 'Ramat Gan', 148);
INSERT INTO public.location VALUES (199, 'Fitness Hub 199', 'Tel Aviv', 314);
INSERT INTO public.location VALUES (200, 'Athletic Complex 200', 'Jerusalem', 140);


--
-- TOC entry 5086 (class 0 OID 17192)
-- Dependencies: 227
-- Data for Name: needs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.needs VALUES (55, 174, 11);
INSERT INTO public.needs VALUES (168, 23, 4);
INSERT INTO public.needs VALUES (162, 182, 16);
INSERT INTO public.needs VALUES (48, 52, 10);
INSERT INTO public.needs VALUES (81, 160, 12);
INSERT INTO public.needs VALUES (157, 122, 2);
INSERT INTO public.needs VALUES (49, 91, 9);
INSERT INTO public.needs VALUES (166, 73, 18);
INSERT INTO public.needs VALUES (188, 70, 8);
INSERT INTO public.needs VALUES (17, 9, 8);
INSERT INTO public.needs VALUES (81, 131, 8);
INSERT INTO public.needs VALUES (3, 31, 1);
INSERT INTO public.needs VALUES (118, 139, 2);
INSERT INTO public.needs VALUES (42, 141, 18);
INSERT INTO public.needs VALUES (17, 74, 11);
INSERT INTO public.needs VALUES (44, 160, 12);
INSERT INTO public.needs VALUES (185, 139, 9);
INSERT INTO public.needs VALUES (164, 34, 7);
INSERT INTO public.needs VALUES (85, 179, 4);
INSERT INTO public.needs VALUES (117, 139, 19);
INSERT INTO public.needs VALUES (22, 143, 5);
INSERT INTO public.needs VALUES (124, 54, 2);
INSERT INTO public.needs VALUES (116, 98, 14);
INSERT INTO public.needs VALUES (182, 132, 13);
INSERT INTO public.needs VALUES (123, 114, 5);
INSERT INTO public.needs VALUES (87, 161, 6);
INSERT INTO public.needs VALUES (84, 38, 8);
INSERT INTO public.needs VALUES (160, 87, 14);
INSERT INTO public.needs VALUES (70, 72, 10);
INSERT INTO public.needs VALUES (174, 185, 14);
INSERT INTO public.needs VALUES (33, 52, 7);
INSERT INTO public.needs VALUES (42, 114, 2);
INSERT INTO public.needs VALUES (98, 122, 10);
INSERT INTO public.needs VALUES (53, 156, 16);
INSERT INTO public.needs VALUES (34, 44, 4);
INSERT INTO public.needs VALUES (178, 177, 15);
INSERT INTO public.needs VALUES (139, 140, 3);
INSERT INTO public.needs VALUES (199, 190, 8);
INSERT INTO public.needs VALUES (102, 113, 19);
INSERT INTO public.needs VALUES (34, 29, 16);
INSERT INTO public.needs VALUES (76, 16, 3);
INSERT INTO public.needs VALUES (167, 118, 3);
INSERT INTO public.needs VALUES (5, 83, 6);
INSERT INTO public.needs VALUES (112, 39, 17);
INSERT INTO public.needs VALUES (162, 108, 18);
INSERT INTO public.needs VALUES (180, 24, 5);
INSERT INTO public.needs VALUES (22, 43, 2);
INSERT INTO public.needs VALUES (186, 146, 2);
INSERT INTO public.needs VALUES (25, 196, 12);
INSERT INTO public.needs VALUES (193, 144, 9);
INSERT INTO public.needs VALUES (196, 32, 20);
INSERT INTO public.needs VALUES (151, 56, 12);
INSERT INTO public.needs VALUES (158, 159, 15);
INSERT INTO public.needs VALUES (88, 83, 11);
INSERT INTO public.needs VALUES (46, 50, 20);
INSERT INTO public.needs VALUES (165, 111, 13);
INSERT INTO public.needs VALUES (171, 83, 7);
INSERT INTO public.needs VALUES (197, 100, 20);
INSERT INTO public.needs VALUES (66, 193, 20);
INSERT INTO public.needs VALUES (147, 76, 10);
INSERT INTO public.needs VALUES (21, 129, 9);
INSERT INTO public.needs VALUES (200, 200, 1);
INSERT INTO public.needs VALUES (2, 144, 10);
INSERT INTO public.needs VALUES (96, 160, 7);
INSERT INTO public.needs VALUES (142, 46, 14);
INSERT INTO public.needs VALUES (115, 190, 13);
INSERT INTO public.needs VALUES (60, 20, 14);
INSERT INTO public.needs VALUES (150, 70, 3);
INSERT INTO public.needs VALUES (62, 45, 16);
INSERT INTO public.needs VALUES (24, 191, 2);
INSERT INTO public.needs VALUES (10, 7, 15);
INSERT INTO public.needs VALUES (169, 149, 9);
INSERT INTO public.needs VALUES (77, 96, 10);
INSERT INTO public.needs VALUES (130, 118, 4);
INSERT INTO public.needs VALUES (3, 35, 7);
INSERT INTO public.needs VALUES (177, 116, 20);
INSERT INTO public.needs VALUES (67, 146, 16);
INSERT INTO public.needs VALUES (11, 28, 9);
INSERT INTO public.needs VALUES (93, 170, 1);
INSERT INTO public.needs VALUES (117, 136, 10);
INSERT INTO public.needs VALUES (84, 87, 10);
INSERT INTO public.needs VALUES (8, 128, 18);
INSERT INTO public.needs VALUES (197, 164, 8);
INSERT INTO public.needs VALUES (56, 89, 11);
INSERT INTO public.needs VALUES (42, 14, 2);
INSERT INTO public.needs VALUES (191, 1, 18);
INSERT INTO public.needs VALUES (28, 4, 14);
INSERT INTO public.needs VALUES (74, 122, 9);
INSERT INTO public.needs VALUES (61, 105, 5);
INSERT INTO public.needs VALUES (112, 13, 10);
INSERT INTO public.needs VALUES (48, 33, 5);
INSERT INTO public.needs VALUES (167, 88, 1);
INSERT INTO public.needs VALUES (131, 109, 10);
INSERT INTO public.needs VALUES (56, 110, 5);
INSERT INTO public.needs VALUES (53, 198, 3);
INSERT INTO public.needs VALUES (180, 177, 7);
INSERT INTO public.needs VALUES (135, 94, 16);
INSERT INTO public.needs VALUES (169, 151, 9);
INSERT INTO public.needs VALUES (30, 139, 16);
INSERT INTO public.needs VALUES (87, 36, 17);
INSERT INTO public.needs VALUES (120, 70, 2);
INSERT INTO public.needs VALUES (66, 90, 20);
INSERT INTO public.needs VALUES (36, 63, 18);
INSERT INTO public.needs VALUES (86, 24, 6);
INSERT INTO public.needs VALUES (59, 25, 1);
INSERT INTO public.needs VALUES (6, 77, 4);
INSERT INTO public.needs VALUES (14, 19, 20);
INSERT INTO public.needs VALUES (83, 173, 2);
INSERT INTO public.needs VALUES (8, 49, 17);
INSERT INTO public.needs VALUES (146, 192, 3);
INSERT INTO public.needs VALUES (85, 139, 18);
INSERT INTO public.needs VALUES (41, 41, 3);
INSERT INTO public.needs VALUES (185, 144, 20);
INSERT INTO public.needs VALUES (29, 149, 4);
INSERT INTO public.needs VALUES (16, 12, 8);
INSERT INTO public.needs VALUES (2, 82, 6);
INSERT INTO public.needs VALUES (29, 43, 3);
INSERT INTO public.needs VALUES (189, 174, 13);
INSERT INTO public.needs VALUES (115, 85, 6);
INSERT INTO public.needs VALUES (56, 192, 17);
INSERT INTO public.needs VALUES (148, 71, 10);
INSERT INTO public.needs VALUES (155, 83, 9);
INSERT INTO public.needs VALUES (18, 110, 15);
INSERT INTO public.needs VALUES (42, 68, 1);
INSERT INTO public.needs VALUES (193, 115, 18);
INSERT INTO public.needs VALUES (119, 97, 3);
INSERT INTO public.needs VALUES (21, 178, 4);
INSERT INTO public.needs VALUES (135, 73, 6);
INSERT INTO public.needs VALUES (165, 133, 9);
INSERT INTO public.needs VALUES (128, 40, 18);
INSERT INTO public.needs VALUES (198, 8, 13);
INSERT INTO public.needs VALUES (42, 36, 15);
INSERT INTO public.needs VALUES (107, 129, 3);
INSERT INTO public.needs VALUES (198, 9, 12);
INSERT INTO public.needs VALUES (167, 183, 15);
INSERT INTO public.needs VALUES (154, 142, 4);
INSERT INTO public.needs VALUES (103, 177, 18);
INSERT INTO public.needs VALUES (167, 198, 18);
INSERT INTO public.needs VALUES (9, 45, 6);
INSERT INTO public.needs VALUES (120, 96, 5);
INSERT INTO public.needs VALUES (123, 158, 6);
INSERT INTO public.needs VALUES (35, 170, 14);
INSERT INTO public.needs VALUES (65, 124, 11);
INSERT INTO public.needs VALUES (2, 164, 19);
INSERT INTO public.needs VALUES (13, 172, 14);
INSERT INTO public.needs VALUES (37, 170, 5);
INSERT INTO public.needs VALUES (84, 184, 3);
INSERT INTO public.needs VALUES (30, 160, 14);
INSERT INTO public.needs VALUES (16, 178, 4);
INSERT INTO public.needs VALUES (68, 187, 3);
INSERT INTO public.needs VALUES (110, 171, 13);
INSERT INTO public.needs VALUES (182, 119, 2);
INSERT INTO public.needs VALUES (120, 192, 14);
INSERT INTO public.needs VALUES (128, 170, 6);
INSERT INTO public.needs VALUES (97, 130, 10);
INSERT INTO public.needs VALUES (164, 123, 3);
INSERT INTO public.needs VALUES (47, 73, 3);
INSERT INTO public.needs VALUES (40, 96, 8);
INSERT INTO public.needs VALUES (190, 20, 9);
INSERT INTO public.needs VALUES (32, 181, 19);
INSERT INTO public.needs VALUES (61, 10, 18);
INSERT INTO public.needs VALUES (138, 88, 15);
INSERT INTO public.needs VALUES (199, 108, 8);
INSERT INTO public.needs VALUES (92, 68, 3);
INSERT INTO public.needs VALUES (184, 23, 20);
INSERT INTO public.needs VALUES (108, 89, 1);
INSERT INTO public.needs VALUES (110, 52, 12);
INSERT INTO public.needs VALUES (147, 160, 6);
INSERT INTO public.needs VALUES (191, 176, 5);
INSERT INTO public.needs VALUES (173, 82, 18);
INSERT INTO public.needs VALUES (13, 94, 11);
INSERT INTO public.needs VALUES (115, 25, 2);
INSERT INTO public.needs VALUES (78, 23, 6);
INSERT INTO public.needs VALUES (168, 6, 17);
INSERT INTO public.needs VALUES (107, 75, 3);
INSERT INTO public.needs VALUES (36, 147, 15);
INSERT INTO public.needs VALUES (166, 92, 12);
INSERT INTO public.needs VALUES (37, 127, 14);
INSERT INTO public.needs VALUES (156, 81, 8);
INSERT INTO public.needs VALUES (75, 107, 20);
INSERT INTO public.needs VALUES (195, 16, 16);
INSERT INTO public.needs VALUES (2, 189, 13);
INSERT INTO public.needs VALUES (112, 30, 3);
INSERT INTO public.needs VALUES (79, 20, 16);
INSERT INTO public.needs VALUES (54, 179, 15);
INSERT INTO public.needs VALUES (102, 87, 11);
INSERT INTO public.needs VALUES (70, 150, 1);
INSERT INTO public.needs VALUES (195, 8, 15);
INSERT INTO public.needs VALUES (140, 179, 14);
INSERT INTO public.needs VALUES (7, 142, 15);
INSERT INTO public.needs VALUES (153, 131, 14);
INSERT INTO public.needs VALUES (190, 13, 6);
INSERT INTO public.needs VALUES (156, 37, 8);
INSERT INTO public.needs VALUES (188, 175, 6);
INSERT INTO public.needs VALUES (113, 50, 6);
INSERT INTO public.needs VALUES (65, 181, 8);
INSERT INTO public.needs VALUES (162, 28, 13);
INSERT INTO public.needs VALUES (30, 63, 9);
INSERT INTO public.needs VALUES (144, 18, 2);
INSERT INTO public.needs VALUES (112, 68, 18);
INSERT INTO public.needs VALUES (125, 105, 9);
INSERT INTO public.needs VALUES (169, 78, 2);
INSERT INTO public.needs VALUES (19, 68, 11);
INSERT INTO public.needs VALUES (142, 147, 18);
INSERT INTO public.needs VALUES (5, 144, 6);
INSERT INTO public.needs VALUES (102, 149, 18);
INSERT INTO public.needs VALUES (91, 162, 8);
INSERT INTO public.needs VALUES (182, 144, 14);
INSERT INTO public.needs VALUES (191, 17, 16);
INSERT INTO public.needs VALUES (164, 45, 5);
INSERT INTO public.needs VALUES (84, 72, 5);
INSERT INTO public.needs VALUES (113, 151, 1);
INSERT INTO public.needs VALUES (166, 26, 16);
INSERT INTO public.needs VALUES (9, 180, 2);
INSERT INTO public.needs VALUES (60, 114, 7);
INSERT INTO public.needs VALUES (79, 7, 7);
INSERT INTO public.needs VALUES (198, 108, 12);
INSERT INTO public.needs VALUES (62, 134, 5);
INSERT INTO public.needs VALUES (22, 141, 5);
INSERT INTO public.needs VALUES (108, 164, 8);
INSERT INTO public.needs VALUES (61, 192, 2);
INSERT INTO public.needs VALUES (113, 49, 18);
INSERT INTO public.needs VALUES (6, 90, 13);
INSERT INTO public.needs VALUES (196, 57, 12);
INSERT INTO public.needs VALUES (151, 102, 20);
INSERT INTO public.needs VALUES (40, 149, 4);
INSERT INTO public.needs VALUES (165, 103, 2);
INSERT INTO public.needs VALUES (27, 58, 16);
INSERT INTO public.needs VALUES (10, 153, 13);
INSERT INTO public.needs VALUES (46, 186, 18);
INSERT INTO public.needs VALUES (100, 108, 2);
INSERT INTO public.needs VALUES (145, 130, 12);
INSERT INTO public.needs VALUES (6, 33, 4);
INSERT INTO public.needs VALUES (34, 157, 2);
INSERT INTO public.needs VALUES (92, 155, 19);
INSERT INTO public.needs VALUES (63, 129, 12);
INSERT INTO public.needs VALUES (91, 148, 20);
INSERT INTO public.needs VALUES (191, 8, 6);
INSERT INTO public.needs VALUES (88, 119, 17);
INSERT INTO public.needs VALUES (150, 140, 15);
INSERT INTO public.needs VALUES (10, 56, 15);
INSERT INTO public.needs VALUES (145, 105, 4);
INSERT INTO public.needs VALUES (27, 76, 15);
INSERT INTO public.needs VALUES (103, 173, 1);
INSERT INTO public.needs VALUES (55, 15, 4);
INSERT INTO public.needs VALUES (73, 129, 1);
INSERT INTO public.needs VALUES (99, 70, 14);
INSERT INTO public.needs VALUES (103, 95, 11);
INSERT INTO public.needs VALUES (38, 66, 16);
INSERT INTO public.needs VALUES (158, 64, 3);
INSERT INTO public.needs VALUES (23, 2, 14);
INSERT INTO public.needs VALUES (123, 100, 6);
INSERT INTO public.needs VALUES (54, 11, 14);
INSERT INTO public.needs VALUES (51, 40, 14);
INSERT INTO public.needs VALUES (185, 85, 20);
INSERT INTO public.needs VALUES (78, 66, 9);
INSERT INTO public.needs VALUES (88, 152, 15);
INSERT INTO public.needs VALUES (148, 185, 2);
INSERT INTO public.needs VALUES (133, 143, 17);
INSERT INTO public.needs VALUES (77, 100, 19);
INSERT INTO public.needs VALUES (53, 187, 19);
INSERT INTO public.needs VALUES (36, 96, 1);
INSERT INTO public.needs VALUES (113, 167, 11);
INSERT INTO public.needs VALUES (159, 116, 19);
INSERT INTO public.needs VALUES (33, 177, 8);
INSERT INTO public.needs VALUES (35, 42, 3);
INSERT INTO public.needs VALUES (103, 191, 16);
INSERT INTO public.needs VALUES (69, 74, 12);
INSERT INTO public.needs VALUES (180, 138, 12);
INSERT INTO public.needs VALUES (108, 125, 8);
INSERT INTO public.needs VALUES (66, 61, 2);
INSERT INTO public.needs VALUES (21, 65, 5);
INSERT INTO public.needs VALUES (60, 109, 15);
INSERT INTO public.needs VALUES (174, 104, 16);
INSERT INTO public.needs VALUES (88, 86, 4);
INSERT INTO public.needs VALUES (19, 7, 13);
INSERT INTO public.needs VALUES (68, 111, 8);
INSERT INTO public.needs VALUES (158, 103, 17);
INSERT INTO public.needs VALUES (60, 108, 5);
INSERT INTO public.needs VALUES (40, 179, 18);
INSERT INTO public.needs VALUES (148, 155, 5);
INSERT INTO public.needs VALUES (148, 177, 19);
INSERT INTO public.needs VALUES (5, 116, 2);
INSERT INTO public.needs VALUES (110, 75, 10);
INSERT INTO public.needs VALUES (77, 116, 18);
INSERT INTO public.needs VALUES (144, 85, 17);
INSERT INTO public.needs VALUES (191, 18, 19);
INSERT INTO public.needs VALUES (128, 81, 11);
INSERT INTO public.needs VALUES (39, 198, 12);
INSERT INTO public.needs VALUES (7, 18, 10);
INSERT INTO public.needs VALUES (90, 82, 8);
INSERT INTO public.needs VALUES (83, 55, 14);
INSERT INTO public.needs VALUES (85, 23, 12);
INSERT INTO public.needs VALUES (51, 49, 18);
INSERT INTO public.needs VALUES (124, 96, 17);
INSERT INTO public.needs VALUES (43, 107, 11);
INSERT INTO public.needs VALUES (195, 69, 19);
INSERT INTO public.needs VALUES (98, 141, 19);
INSERT INTO public.needs VALUES (156, 23, 16);
INSERT INTO public.needs VALUES (128, 185, 10);
INSERT INTO public.needs VALUES (145, 132, 11);
INSERT INTO public.needs VALUES (57, 93, 15);
INSERT INTO public.needs VALUES (8, 149, 10);
INSERT INTO public.needs VALUES (75, 57, 19);
INSERT INTO public.needs VALUES (180, 95, 17);
INSERT INTO public.needs VALUES (33, 50, 17);
INSERT INTO public.needs VALUES (182, 66, 20);
INSERT INTO public.needs VALUES (126, 115, 11);
INSERT INTO public.needs VALUES (11, 119, 6);
INSERT INTO public.needs VALUES (196, 54, 10);
INSERT INTO public.needs VALUES (159, 174, 6);
INSERT INTO public.needs VALUES (132, 170, 16);
INSERT INTO public.needs VALUES (89, 18, 17);
INSERT INTO public.needs VALUES (34, 35, 3);
INSERT INTO public.needs VALUES (51, 61, 12);
INSERT INTO public.needs VALUES (140, 181, 15);
INSERT INTO public.needs VALUES (117, 43, 17);
INSERT INTO public.needs VALUES (83, 135, 3);
INSERT INTO public.needs VALUES (49, 150, 6);
INSERT INTO public.needs VALUES (79, 151, 12);
INSERT INTO public.needs VALUES (62, 191, 19);
INSERT INTO public.needs VALUES (185, 102, 7);
INSERT INTO public.needs VALUES (130, 126, 13);
INSERT INTO public.needs VALUES (31, 92, 2);
INSERT INTO public.needs VALUES (157, 93, 16);
INSERT INTO public.needs VALUES (122, 153, 9);
INSERT INTO public.needs VALUES (60, 38, 11);
INSERT INTO public.needs VALUES (98, 41, 2);
INSERT INTO public.needs VALUES (183, 34, 14);
INSERT INTO public.needs VALUES (169, 136, 15);
INSERT INTO public.needs VALUES (16, 114, 10);
INSERT INTO public.needs VALUES (22, 124, 4);
INSERT INTO public.needs VALUES (38, 3, 16);
INSERT INTO public.needs VALUES (111, 29, 8);
INSERT INTO public.needs VALUES (58, 184, 13);
INSERT INTO public.needs VALUES (188, 152, 12);
INSERT INTO public.needs VALUES (59, 111, 18);
INSERT INTO public.needs VALUES (50, 176, 17);
INSERT INTO public.needs VALUES (87, 76, 3);
INSERT INTO public.needs VALUES (174, 180, 10);
INSERT INTO public.needs VALUES (18, 74, 9);
INSERT INTO public.needs VALUES (46, 109, 7);
INSERT INTO public.needs VALUES (90, 60, 20);
INSERT INTO public.needs VALUES (115, 3, 13);
INSERT INTO public.needs VALUES (76, 191, 14);
INSERT INTO public.needs VALUES (165, 46, 15);
INSERT INTO public.needs VALUES (10, 118, 18);
INSERT INTO public.needs VALUES (39, 2, 1);
INSERT INTO public.needs VALUES (27, 186, 16);
INSERT INTO public.needs VALUES (166, 187, 1);


--
-- TOC entry 5085 (class 0 OID 17175)
-- Dependencies: 226
-- Data for Name: participate_in; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.participate_in VALUES (13, 146);
INSERT INTO public.participate_in VALUES (82, 193);
INSERT INTO public.participate_in VALUES (30, 165);
INSERT INTO public.participate_in VALUES (149, 42);
INSERT INTO public.participate_in VALUES (1, 84);
INSERT INTO public.participate_in VALUES (63, 170);
INSERT INTO public.participate_in VALUES (67, 44);
INSERT INTO public.participate_in VALUES (45, 163);
INSERT INTO public.participate_in VALUES (88, 30);
INSERT INTO public.participate_in VALUES (43, 49);
INSERT INTO public.participate_in VALUES (55, 116);
INSERT INTO public.participate_in VALUES (15, 22);
INSERT INTO public.participate_in VALUES (57, 15);
INSERT INTO public.participate_in VALUES (125, 69);
INSERT INTO public.participate_in VALUES (99, 159);
INSERT INTO public.participate_in VALUES (43, 30);
INSERT INTO public.participate_in VALUES (3, 7);
INSERT INTO public.participate_in VALUES (126, 96);
INSERT INTO public.participate_in VALUES (80, 194);
INSERT INTO public.participate_in VALUES (54, 144);
INSERT INTO public.participate_in VALUES (70, 38);
INSERT INTO public.participate_in VALUES (122, 184);
INSERT INTO public.participate_in VALUES (126, 105);
INSERT INTO public.participate_in VALUES (37, 16);
INSERT INTO public.participate_in VALUES (72, 142);
INSERT INTO public.participate_in VALUES (86, 153);
INSERT INTO public.participate_in VALUES (110, 26);
INSERT INTO public.participate_in VALUES (104, 127);
INSERT INTO public.participate_in VALUES (144, 132);
INSERT INTO public.participate_in VALUES (139, 28);
INSERT INTO public.participate_in VALUES (66, 161);
INSERT INTO public.participate_in VALUES (85, 113);
INSERT INTO public.participate_in VALUES (131, 149);
INSERT INTO public.participate_in VALUES (66, 134);
INSERT INTO public.participate_in VALUES (20, 137);
INSERT INTO public.participate_in VALUES (141, 69);
INSERT INTO public.participate_in VALUES (84, 60);
INSERT INTO public.participate_in VALUES (136, 166);
INSERT INTO public.participate_in VALUES (14, 157);
INSERT INTO public.participate_in VALUES (108, 144);
INSERT INTO public.participate_in VALUES (130, 192);
INSERT INTO public.participate_in VALUES (53, 25);
INSERT INTO public.participate_in VALUES (116, 6);
INSERT INTO public.participate_in VALUES (9, 174);
INSERT INTO public.participate_in VALUES (30, 74);
INSERT INTO public.participate_in VALUES (37, 114);
INSERT INTO public.participate_in VALUES (20, 179);
INSERT INTO public.participate_in VALUES (64, 150);
INSERT INTO public.participate_in VALUES (3, 177);
INSERT INTO public.participate_in VALUES (63, 158);
INSERT INTO public.participate_in VALUES (18, 132);
INSERT INTO public.participate_in VALUES (116, 157);
INSERT INTO public.participate_in VALUES (49, 13);
INSERT INTO public.participate_in VALUES (80, 90);
INSERT INTO public.participate_in VALUES (59, 130);
INSERT INTO public.participate_in VALUES (32, 165);
INSERT INTO public.participate_in VALUES (140, 50);
INSERT INTO public.participate_in VALUES (62, 147);
INSERT INTO public.participate_in VALUES (133, 49);
INSERT INTO public.participate_in VALUES (100, 74);
INSERT INTO public.participate_in VALUES (4, 189);
INSERT INTO public.participate_in VALUES (5, 164);
INSERT INTO public.participate_in VALUES (45, 130);
INSERT INTO public.participate_in VALUES (94, 119);
INSERT INTO public.participate_in VALUES (147, 95);
INSERT INTO public.participate_in VALUES (56, 192);
INSERT INTO public.participate_in VALUES (58, 118);
INSERT INTO public.participate_in VALUES (27, 103);
INSERT INTO public.participate_in VALUES (32, 112);
INSERT INTO public.participate_in VALUES (71, 132);
INSERT INTO public.participate_in VALUES (88, 45);
INSERT INTO public.participate_in VALUES (79, 65);
INSERT INTO public.participate_in VALUES (55, 12);
INSERT INTO public.participate_in VALUES (43, 108);
INSERT INTO public.participate_in VALUES (25, 5);
INSERT INTO public.participate_in VALUES (64, 63);
INSERT INTO public.participate_in VALUES (58, 80);
INSERT INTO public.participate_in VALUES (95, 148);
INSERT INTO public.participate_in VALUES (94, 113);
INSERT INTO public.participate_in VALUES (13, 19);
INSERT INTO public.participate_in VALUES (59, 122);
INSERT INTO public.participate_in VALUES (100, 44);
INSERT INTO public.participate_in VALUES (115, 66);
INSERT INTO public.participate_in VALUES (54, 83);
INSERT INTO public.participate_in VALUES (20, 86);
INSERT INTO public.participate_in VALUES (38, 192);
INSERT INTO public.participate_in VALUES (136, 98);
INSERT INTO public.participate_in VALUES (24, 127);
INSERT INTO public.participate_in VALUES (112, 67);
INSERT INTO public.participate_in VALUES (10, 29);
INSERT INTO public.participate_in VALUES (98, 90);
INSERT INTO public.participate_in VALUES (15, 191);
INSERT INTO public.participate_in VALUES (101, 29);
INSERT INTO public.participate_in VALUES (92, 175);
INSERT INTO public.participate_in VALUES (112, 138);
INSERT INTO public.participate_in VALUES (138, 185);
INSERT INTO public.participate_in VALUES (20, 162);
INSERT INTO public.participate_in VALUES (14, 81);
INSERT INTO public.participate_in VALUES (122, 119);
INSERT INTO public.participate_in VALUES (96, 111);
INSERT INTO public.participate_in VALUES (141, 94);
INSERT INTO public.participate_in VALUES (2, 61);
INSERT INTO public.participate_in VALUES (113, 148);
INSERT INTO public.participate_in VALUES (141, 93);
INSERT INTO public.participate_in VALUES (82, 195);
INSERT INTO public.participate_in VALUES (7, 165);
INSERT INTO public.participate_in VALUES (94, 154);
INSERT INTO public.participate_in VALUES (47, 80);
INSERT INTO public.participate_in VALUES (52, 44);
INSERT INTO public.participate_in VALUES (97, 89);
INSERT INTO public.participate_in VALUES (2, 123);
INSERT INTO public.participate_in VALUES (12, 194);
INSERT INTO public.participate_in VALUES (135, 114);
INSERT INTO public.participate_in VALUES (11, 115);
INSERT INTO public.participate_in VALUES (137, 105);
INSERT INTO public.participate_in VALUES (110, 116);
INSERT INTO public.participate_in VALUES (139, 59);
INSERT INTO public.participate_in VALUES (118, 103);
INSERT INTO public.participate_in VALUES (39, 151);
INSERT INTO public.participate_in VALUES (71, 70);
INSERT INTO public.participate_in VALUES (93, 11);
INSERT INTO public.participate_in VALUES (75, 30);
INSERT INTO public.participate_in VALUES (144, 115);
INSERT INTO public.participate_in VALUES (6, 155);
INSERT INTO public.participate_in VALUES (93, 93);
INSERT INTO public.participate_in VALUES (44, 55);
INSERT INTO public.participate_in VALUES (59, 175);
INSERT INTO public.participate_in VALUES (66, 81);
INSERT INTO public.participate_in VALUES (5, 186);
INSERT INTO public.participate_in VALUES (96, 104);
INSERT INTO public.participate_in VALUES (1, 22);
INSERT INTO public.participate_in VALUES (146, 86);
INSERT INTO public.participate_in VALUES (53, 137);
INSERT INTO public.participate_in VALUES (150, 27);
INSERT INTO public.participate_in VALUES (123, 192);
INSERT INTO public.participate_in VALUES (104, 132);
INSERT INTO public.participate_in VALUES (125, 111);
INSERT INTO public.participate_in VALUES (132, 113);
INSERT INTO public.participate_in VALUES (128, 40);
INSERT INTO public.participate_in VALUES (82, 2);
INSERT INTO public.participate_in VALUES (127, 60);
INSERT INTO public.participate_in VALUES (126, 128);
INSERT INTO public.participate_in VALUES (14, 185);
INSERT INTO public.participate_in VALUES (77, 135);
INSERT INTO public.participate_in VALUES (150, 199);
INSERT INTO public.participate_in VALUES (114, 197);
INSERT INTO public.participate_in VALUES (72, 175);
INSERT INTO public.participate_in VALUES (27, 1);
INSERT INTO public.participate_in VALUES (70, 65);
INSERT INTO public.participate_in VALUES (42, 164);
INSERT INTO public.participate_in VALUES (69, 74);
INSERT INTO public.participate_in VALUES (144, 144);
INSERT INTO public.participate_in VALUES (111, 174);
INSERT INTO public.participate_in VALUES (85, 151);
INSERT INTO public.participate_in VALUES (89, 88);
INSERT INTO public.participate_in VALUES (70, 88);
INSERT INTO public.participate_in VALUES (7, 114);
INSERT INTO public.participate_in VALUES (20, 189);
INSERT INTO public.participate_in VALUES (26, 135);
INSERT INTO public.participate_in VALUES (65, 95);
INSERT INTO public.participate_in VALUES (92, 92);
INSERT INTO public.participate_in VALUES (53, 96);
INSERT INTO public.participate_in VALUES (32, 33);
INSERT INTO public.participate_in VALUES (49, 123);
INSERT INTO public.participate_in VALUES (62, 69);
INSERT INTO public.participate_in VALUES (143, 133);
INSERT INTO public.participate_in VALUES (10, 103);
INSERT INTO public.participate_in VALUES (16, 125);
INSERT INTO public.participate_in VALUES (80, 50);
INSERT INTO public.participate_in VALUES (106, 200);
INSERT INTO public.participate_in VALUES (11, 42);
INSERT INTO public.participate_in VALUES (78, 36);
INSERT INTO public.participate_in VALUES (105, 15);
INSERT INTO public.participate_in VALUES (46, 67);
INSERT INTO public.participate_in VALUES (55, 155);
INSERT INTO public.participate_in VALUES (94, 77);
INSERT INTO public.participate_in VALUES (48, 12);
INSERT INTO public.participate_in VALUES (98, 45);
INSERT INTO public.participate_in VALUES (42, 26);
INSERT INTO public.participate_in VALUES (108, 195);
INSERT INTO public.participate_in VALUES (81, 33);
INSERT INTO public.participate_in VALUES (85, 181);
INSERT INTO public.participate_in VALUES (76, 167);
INSERT INTO public.participate_in VALUES (63, 154);
INSERT INTO public.participate_in VALUES (78, 197);
INSERT INTO public.participate_in VALUES (42, 93);
INSERT INTO public.participate_in VALUES (73, 150);
INSERT INTO public.participate_in VALUES (142, 16);
INSERT INTO public.participate_in VALUES (10, 197);
INSERT INTO public.participate_in VALUES (62, 57);
INSERT INTO public.participate_in VALUES (144, 90);
INSERT INTO public.participate_in VALUES (13, 53);
INSERT INTO public.participate_in VALUES (150, 118);
INSERT INTO public.participate_in VALUES (79, 183);
INSERT INTO public.participate_in VALUES (136, 145);
INSERT INTO public.participate_in VALUES (148, 128);
INSERT INTO public.participate_in VALUES (83, 42);
INSERT INTO public.participate_in VALUES (54, 114);
INSERT INTO public.participate_in VALUES (147, 66);
INSERT INTO public.participate_in VALUES (81, 66);
INSERT INTO public.participate_in VALUES (3, 154);
INSERT INTO public.participate_in VALUES (110, 25);
INSERT INTO public.participate_in VALUES (18, 188);
INSERT INTO public.participate_in VALUES (8, 93);
INSERT INTO public.participate_in VALUES (89, 122);
INSERT INTO public.participate_in VALUES (136, 58);
INSERT INTO public.participate_in VALUES (125, 90);
INSERT INTO public.participate_in VALUES (5, 138);
INSERT INTO public.participate_in VALUES (4, 109);
INSERT INTO public.participate_in VALUES (7, 39);
INSERT INTO public.participate_in VALUES (25, 4);
INSERT INTO public.participate_in VALUES (137, 161);
INSERT INTO public.participate_in VALUES (118, 95);
INSERT INTO public.participate_in VALUES (8, 130);
INSERT INTO public.participate_in VALUES (25, 176);
INSERT INTO public.participate_in VALUES (100, 200);
INSERT INTO public.participate_in VALUES (57, 87);
INSERT INTO public.participate_in VALUES (123, 98);
INSERT INTO public.participate_in VALUES (58, 189);
INSERT INTO public.participate_in VALUES (106, 77);
INSERT INTO public.participate_in VALUES (48, 173);
INSERT INTO public.participate_in VALUES (9, 199);
INSERT INTO public.participate_in VALUES (63, 159);
INSERT INTO public.participate_in VALUES (129, 199);
INSERT INTO public.participate_in VALUES (55, 146);
INSERT INTO public.participate_in VALUES (98, 58);
INSERT INTO public.participate_in VALUES (87, 122);
INSERT INTO public.participate_in VALUES (89, 134);
INSERT INTO public.participate_in VALUES (61, 187);
INSERT INTO public.participate_in VALUES (11, 49);
INSERT INTO public.participate_in VALUES (146, 77);
INSERT INTO public.participate_in VALUES (119, 104);
INSERT INTO public.participate_in VALUES (67, 48);
INSERT INTO public.participate_in VALUES (77, 89);
INSERT INTO public.participate_in VALUES (49, 37);
INSERT INTO public.participate_in VALUES (136, 105);
INSERT INTO public.participate_in VALUES (33, 87);
INSERT INTO public.participate_in VALUES (123, 33);
INSERT INTO public.participate_in VALUES (8, 17);
INSERT INTO public.participate_in VALUES (13, 178);
INSERT INTO public.participate_in VALUES (96, 9);
INSERT INTO public.participate_in VALUES (54, 194);
INSERT INTO public.participate_in VALUES (77, 179);
INSERT INTO public.participate_in VALUES (22, 14);
INSERT INTO public.participate_in VALUES (35, 124);
INSERT INTO public.participate_in VALUES (147, 59);
INSERT INTO public.participate_in VALUES (95, 178);
INSERT INTO public.participate_in VALUES (127, 24);
INSERT INTO public.participate_in VALUES (33, 30);
INSERT INTO public.participate_in VALUES (110, 109);
INSERT INTO public.participate_in VALUES (138, 183);
INSERT INTO public.participate_in VALUES (131, 197);
INSERT INTO public.participate_in VALUES (112, 19);
INSERT INTO public.participate_in VALUES (81, 110);
INSERT INTO public.participate_in VALUES (40, 196);
INSERT INTO public.participate_in VALUES (40, 58);
INSERT INTO public.participate_in VALUES (10, 175);
INSERT INTO public.participate_in VALUES (98, 19);
INSERT INTO public.participate_in VALUES (60, 123);
INSERT INTO public.participate_in VALUES (92, 122);
INSERT INTO public.participate_in VALUES (65, 146);
INSERT INTO public.participate_in VALUES (138, 88);
INSERT INTO public.participate_in VALUES (39, 61);
INSERT INTO public.participate_in VALUES (76, 138);
INSERT INTO public.participate_in VALUES (100, 146);
INSERT INTO public.participate_in VALUES (89, 183);
INSERT INTO public.participate_in VALUES (142, 125);
INSERT INTO public.participate_in VALUES (78, 119);
INSERT INTO public.participate_in VALUES (146, 30);
INSERT INTO public.participate_in VALUES (78, 78);
INSERT INTO public.participate_in VALUES (80, 34);
INSERT INTO public.participate_in VALUES (77, 24);
INSERT INTO public.participate_in VALUES (40, 87);
INSERT INTO public.participate_in VALUES (80, 139);
INSERT INTO public.participate_in VALUES (39, 105);
INSERT INTO public.participate_in VALUES (11, 24);
INSERT INTO public.participate_in VALUES (77, 137);
INSERT INTO public.participate_in VALUES (7, 136);
INSERT INTO public.participate_in VALUES (108, 43);
INSERT INTO public.participate_in VALUES (73, 175);
INSERT INTO public.participate_in VALUES (123, 198);
INSERT INTO public.participate_in VALUES (90, 2);
INSERT INTO public.participate_in VALUES (129, 193);
INSERT INTO public.participate_in VALUES (145, 179);
INSERT INTO public.participate_in VALUES (18, 93);
INSERT INTO public.participate_in VALUES (132, 77);
INSERT INTO public.participate_in VALUES (99, 68);
INSERT INTO public.participate_in VALUES (81, 76);
INSERT INTO public.participate_in VALUES (33, 187);
INSERT INTO public.participate_in VALUES (125, 162);
INSERT INTO public.participate_in VALUES (10, 116);
INSERT INTO public.participate_in VALUES (4, 54);
INSERT INTO public.participate_in VALUES (69, 118);
INSERT INTO public.participate_in VALUES (106, 100);
INSERT INTO public.participate_in VALUES (58, 134);
INSERT INTO public.participate_in VALUES (4, 160);
INSERT INTO public.participate_in VALUES (114, 61);
INSERT INTO public.participate_in VALUES (1, 160);
INSERT INTO public.participate_in VALUES (29, 154);
INSERT INTO public.participate_in VALUES (6, 145);
INSERT INTO public.participate_in VALUES (55, 48);
INSERT INTO public.participate_in VALUES (138, 94);
INSERT INTO public.participate_in VALUES (41, 168);
INSERT INTO public.participate_in VALUES (42, 12);
INSERT INTO public.participate_in VALUES (30, 180);
INSERT INTO public.participate_in VALUES (1, 151);
INSERT INTO public.participate_in VALUES (18, 75);
INSERT INTO public.participate_in VALUES (134, 82);
INSERT INTO public.participate_in VALUES (126, 104);
INSERT INTO public.participate_in VALUES (68, 14);
INSERT INTO public.participate_in VALUES (89, 91);
INSERT INTO public.participate_in VALUES (2, 82);
INSERT INTO public.participate_in VALUES (143, 140);
INSERT INTO public.participate_in VALUES (46, 166);
INSERT INTO public.participate_in VALUES (30, 153);
INSERT INTO public.participate_in VALUES (19, 189);
INSERT INTO public.participate_in VALUES (144, 8);
INSERT INTO public.participate_in VALUES (68, 66);
INSERT INTO public.participate_in VALUES (40, 139);
INSERT INTO public.participate_in VALUES (6, 73);
INSERT INTO public.participate_in VALUES (12, 175);
INSERT INTO public.participate_in VALUES (13, 15);
INSERT INTO public.participate_in VALUES (62, 74);
INSERT INTO public.participate_in VALUES (93, 33);
INSERT INTO public.participate_in VALUES (49, 133);
INSERT INTO public.participate_in VALUES (108, 138);
INSERT INTO public.participate_in VALUES (20, 31);
INSERT INTO public.participate_in VALUES (91, 159);
INSERT INTO public.participate_in VALUES (60, 42);
INSERT INTO public.participate_in VALUES (33, 52);
INSERT INTO public.participate_in VALUES (67, 198);
INSERT INTO public.participate_in VALUES (32, 54);
INSERT INTO public.participate_in VALUES (93, 68);
INSERT INTO public.participate_in VALUES (56, 90);
INSERT INTO public.participate_in VALUES (78, 126);
INSERT INTO public.participate_in VALUES (82, 105);
INSERT INTO public.participate_in VALUES (114, 91);
INSERT INTO public.participate_in VALUES (9, 73);
INSERT INTO public.participate_in VALUES (128, 103);
INSERT INTO public.participate_in VALUES (77, 59);
INSERT INTO public.participate_in VALUES (148, 177);
INSERT INTO public.participate_in VALUES (67, 82);
INSERT INTO public.participate_in VALUES (102, 174);
INSERT INTO public.participate_in VALUES (139, 63);
INSERT INTO public.participate_in VALUES (80, 15);
INSERT INTO public.participate_in VALUES (79, 69);
INSERT INTO public.participate_in VALUES (26, 195);
INSERT INTO public.participate_in VALUES (125, 89);
INSERT INTO public.participate_in VALUES (59, 199);
INSERT INTO public.participate_in VALUES (51, 121);
INSERT INTO public.participate_in VALUES (131, 121);
INSERT INTO public.participate_in VALUES (8, 75);
INSERT INTO public.participate_in VALUES (3, 186);
INSERT INTO public.participate_in VALUES (81, 52);
INSERT INTO public.participate_in VALUES (40, 50);
INSERT INTO public.participate_in VALUES (110, 45);
INSERT INTO public.participate_in VALUES (9, 188);
INSERT INTO public.participate_in VALUES (119, 2);
INSERT INTO public.participate_in VALUES (143, 3);
INSERT INTO public.participate_in VALUES (132, 180);
INSERT INTO public.participate_in VALUES (58, 122);
INSERT INTO public.participate_in VALUES (3, 141);
INSERT INTO public.participate_in VALUES (108, 89);
INSERT INTO public.participate_in VALUES (36, 78);
INSERT INTO public.participate_in VALUES (115, 2);
INSERT INTO public.participate_in VALUES (8, 50);
INSERT INTO public.participate_in VALUES (5, 3);
INSERT INTO public.participate_in VALUES (63, 99);
INSERT INTO public.participate_in VALUES (119, 61);
INSERT INTO public.participate_in VALUES (138, 26);
INSERT INTO public.participate_in VALUES (100, 87);
INSERT INTO public.participate_in VALUES (32, 31);
INSERT INTO public.participate_in VALUES (2, 108);
INSERT INTO public.participate_in VALUES (107, 2);
INSERT INTO public.participate_in VALUES (41, 79);
INSERT INTO public.participate_in VALUES (120, 31);
INSERT INTO public.participate_in VALUES (59, 26);
INSERT INTO public.participate_in VALUES (130, 166);
INSERT INTO public.participate_in VALUES (93, 22);
INSERT INTO public.participate_in VALUES (89, 174);
INSERT INTO public.participate_in VALUES (54, 87);
INSERT INTO public.participate_in VALUES (139, 178);
INSERT INTO public.participate_in VALUES (124, 71);
INSERT INTO public.participate_in VALUES (74, 12);
INSERT INTO public.participate_in VALUES (76, 122);
INSERT INTO public.participate_in VALUES (72, 154);
INSERT INTO public.participate_in VALUES (88, 6);
INSERT INTO public.participate_in VALUES (85, 141);
INSERT INTO public.participate_in VALUES (59, 63);
INSERT INTO public.participate_in VALUES (55, 56);
INSERT INTO public.participate_in VALUES (60, 53);
INSERT INTO public.participate_in VALUES (27, 80);
INSERT INTO public.participate_in VALUES (119, 197);
INSERT INTO public.participate_in VALUES (82, 119);
INSERT INTO public.participate_in VALUES (58, 83);
INSERT INTO public.participate_in VALUES (147, 173);
INSERT INTO public.participate_in VALUES (71, 4);
INSERT INTO public.participate_in VALUES (52, 72);
INSERT INTO public.participate_in VALUES (63, 54);
INSERT INTO public.participate_in VALUES (103, 147);
INSERT INTO public.participate_in VALUES (85, 93);
INSERT INTO public.participate_in VALUES (25, 78);
INSERT INTO public.participate_in VALUES (74, 169);
INSERT INTO public.participate_in VALUES (38, 35);
INSERT INTO public.participate_in VALUES (80, 23);
INSERT INTO public.participate_in VALUES (144, 185);
INSERT INTO public.participate_in VALUES (30, 11);
INSERT INTO public.participate_in VALUES (1, 199);
INSERT INTO public.participate_in VALUES (89, 59);
INSERT INTO public.participate_in VALUES (131, 104);
INSERT INTO public.participate_in VALUES (32, 60);
INSERT INTO public.participate_in VALUES (13, 4);
INSERT INTO public.participate_in VALUES (63, 91);
INSERT INTO public.participate_in VALUES (67, 124);
INSERT INTO public.participate_in VALUES (70, 35);
INSERT INTO public.participate_in VALUES (30, 113);
INSERT INTO public.participate_in VALUES (138, 95);
INSERT INTO public.participate_in VALUES (17, 5);
INSERT INTO public.participate_in VALUES (132, 154);
INSERT INTO public.participate_in VALUES (32, 85);
INSERT INTO public.participate_in VALUES (1, 15);
INSERT INTO public.participate_in VALUES (146, 196);
INSERT INTO public.participate_in VALUES (9, 155);
INSERT INTO public.participate_in VALUES (148, 111);
INSERT INTO public.participate_in VALUES (131, 40);
INSERT INTO public.participate_in VALUES (42, 68);
INSERT INTO public.participate_in VALUES (118, 155);
INSERT INTO public.participate_in VALUES (79, 128);
INSERT INTO public.participate_in VALUES (143, 187);
INSERT INTO public.participate_in VALUES (33, 115);
INSERT INTO public.participate_in VALUES (71, 31);
INSERT INTO public.participate_in VALUES (52, 160);
INSERT INTO public.participate_in VALUES (104, 107);
INSERT INTO public.participate_in VALUES (59, 86);
INSERT INTO public.participate_in VALUES (77, 65);
INSERT INTO public.participate_in VALUES (123, 96);
INSERT INTO public.participate_in VALUES (112, 197);
INSERT INTO public.participate_in VALUES (48, 118);
INSERT INTO public.participate_in VALUES (30, 181);
INSERT INTO public.participate_in VALUES (38, 155);
INSERT INTO public.participate_in VALUES (91, 163);
INSERT INTO public.participate_in VALUES (94, 70);
INSERT INTO public.participate_in VALUES (24, 86);
INSERT INTO public.participate_in VALUES (7, 13);
INSERT INTO public.participate_in VALUES (42, 130);
INSERT INTO public.participate_in VALUES (18, 36);
INSERT INTO public.participate_in VALUES (33, 180);
INSERT INTO public.participate_in VALUES (36, 110);
INSERT INTO public.participate_in VALUES (64, 144);
INSERT INTO public.participate_in VALUES (47, 144);
INSERT INTO public.participate_in VALUES (201, 153);
INSERT INTO public.participate_in VALUES (202, 37);
INSERT INTO public.participate_in VALUES (203, 24);
INSERT INTO public.participate_in VALUES (204, 113);
INSERT INTO public.participate_in VALUES (205, 171);
INSERT INTO public.participate_in VALUES (206, 102);
INSERT INTO public.participate_in VALUES (207, 196);
INSERT INTO public.participate_in VALUES (207, 110);
INSERT INTO public.participate_in VALUES (208, 13);
INSERT INTO public.participate_in VALUES (208, 131);
INSERT INTO public.participate_in VALUES (208, 170);
INSERT INTO public.participate_in VALUES (209, 17);
INSERT INTO public.participate_in VALUES (209, 93);
INSERT INTO public.participate_in VALUES (210, 199);
INSERT INTO public.participate_in VALUES (210, 6);
INSERT INTO public.participate_in VALUES (210, 139);
INSERT INTO public.participate_in VALUES (211, 136);
INSERT INTO public.participate_in VALUES (211, 129);
INSERT INTO public.participate_in VALUES (211, 147);
INSERT INTO public.participate_in VALUES (212, 18);
INSERT INTO public.participate_in VALUES (213, 108);
INSERT INTO public.participate_in VALUES (213, 66);
INSERT INTO public.participate_in VALUES (213, 38);
INSERT INTO public.participate_in VALUES (214, 22);
INSERT INTO public.participate_in VALUES (214, 21);
INSERT INTO public.participate_in VALUES (214, 155);
INSERT INTO public.participate_in VALUES (215, 154);
INSERT INTO public.participate_in VALUES (215, 40);
INSERT INTO public.participate_in VALUES (216, 174);
INSERT INTO public.participate_in VALUES (216, 191);
INSERT INTO public.participate_in VALUES (216, 5);
INSERT INTO public.participate_in VALUES (217, 131);
INSERT INTO public.participate_in VALUES (217, 69);
INSERT INTO public.participate_in VALUES (218, 6);
INSERT INTO public.participate_in VALUES (218, 115);
INSERT INTO public.participate_in VALUES (219, 80);
INSERT INTO public.participate_in VALUES (220, 154);
INSERT INTO public.participate_in VALUES (220, 73);
INSERT INTO public.participate_in VALUES (220, 161);
INSERT INTO public.participate_in VALUES (221, 152);
INSERT INTO public.participate_in VALUES (221, 184);
INSERT INTO public.participate_in VALUES (222, 166);
INSERT INTO public.participate_in VALUES (223, 176);
INSERT INTO public.participate_in VALUES (224, 80);
INSERT INTO public.participate_in VALUES (225, 75);
INSERT INTO public.participate_in VALUES (226, 111);
INSERT INTO public.participate_in VALUES (226, 129);
INSERT INTO public.participate_in VALUES (226, 159);
INSERT INTO public.participate_in VALUES (227, 103);
INSERT INTO public.participate_in VALUES (227, 134);
INSERT INTO public.participate_in VALUES (228, 33);
INSERT INTO public.participate_in VALUES (228, 30);
INSERT INTO public.participate_in VALUES (229, 148);
INSERT INTO public.participate_in VALUES (229, 34);
INSERT INTO public.participate_in VALUES (230, 48);
INSERT INTO public.participate_in VALUES (230, 178);
INSERT INTO public.participate_in VALUES (230, 136);
INSERT INTO public.participate_in VALUES (231, 149);
INSERT INTO public.participate_in VALUES (232, 96);
INSERT INTO public.participate_in VALUES (232, 28);
INSERT INTO public.participate_in VALUES (232, 32);
INSERT INTO public.participate_in VALUES (233, 191);
INSERT INTO public.participate_in VALUES (233, 103);
INSERT INTO public.participate_in VALUES (234, 156);
INSERT INTO public.participate_in VALUES (234, 1);
INSERT INTO public.participate_in VALUES (234, 165);
INSERT INTO public.participate_in VALUES (235, 41);
INSERT INTO public.participate_in VALUES (236, 18);
INSERT INTO public.participate_in VALUES (237, 23);
INSERT INTO public.participate_in VALUES (237, 76);
INSERT INTO public.participate_in VALUES (238, 3);
INSERT INTO public.participate_in VALUES (238, 171);
INSERT INTO public.participate_in VALUES (238, 172);
INSERT INTO public.participate_in VALUES (239, 174);
INSERT INTO public.participate_in VALUES (240, 186);
INSERT INTO public.participate_in VALUES (240, 123);
INSERT INTO public.participate_in VALUES (241, 190);
INSERT INTO public.participate_in VALUES (241, 89);
INSERT INTO public.participate_in VALUES (242, 125);
INSERT INTO public.participate_in VALUES (243, 120);
INSERT INTO public.participate_in VALUES (243, 27);
INSERT INTO public.participate_in VALUES (244, 119);
INSERT INTO public.participate_in VALUES (244, 78);
INSERT INTO public.participate_in VALUES (244, 94);
INSERT INTO public.participate_in VALUES (245, 2);
INSERT INTO public.participate_in VALUES (246, 122);
INSERT INTO public.participate_in VALUES (246, 59);
INSERT INTO public.participate_in VALUES (247, 118);
INSERT INTO public.participate_in VALUES (247, 23);
INSERT INTO public.participate_in VALUES (247, 155);
INSERT INTO public.participate_in VALUES (248, 57);
INSERT INTO public.participate_in VALUES (248, 6);
INSERT INTO public.participate_in VALUES (248, 16);
INSERT INTO public.participate_in VALUES (249, 145);
INSERT INTO public.participate_in VALUES (249, 52);
INSERT INTO public.participate_in VALUES (249, 23);
INSERT INTO public.participate_in VALUES (250, 40);
INSERT INTO public.participate_in VALUES (250, 19);
INSERT INTO public.participate_in VALUES (250, 59);
INSERT INTO public.participate_in VALUES (251, 81);
INSERT INTO public.participate_in VALUES (252, 111);
INSERT INTO public.participate_in VALUES (253, 123);
INSERT INTO public.participate_in VALUES (253, 55);
INSERT INTO public.participate_in VALUES (253, 136);
INSERT INTO public.participate_in VALUES (254, 150);
INSERT INTO public.participate_in VALUES (255, 178);
INSERT INTO public.participate_in VALUES (255, 121);
INSERT INTO public.participate_in VALUES (256, 153);
INSERT INTO public.participate_in VALUES (257, 72);
INSERT INTO public.participate_in VALUES (257, 145);
INSERT INTO public.participate_in VALUES (257, 56);
INSERT INTO public.participate_in VALUES (258, 65);
INSERT INTO public.participate_in VALUES (258, 144);
INSERT INTO public.participate_in VALUES (259, 148);
INSERT INTO public.participate_in VALUES (260, 145);
INSERT INTO public.participate_in VALUES (261, 61);
INSERT INTO public.participate_in VALUES (262, 36);
INSERT INTO public.participate_in VALUES (263, 137);
INSERT INTO public.participate_in VALUES (264, 179);
INSERT INTO public.participate_in VALUES (264, 104);
INSERT INTO public.participate_in VALUES (265, 64);
INSERT INTO public.participate_in VALUES (265, 9);
INSERT INTO public.participate_in VALUES (266, 155);
INSERT INTO public.participate_in VALUES (266, 58);
INSERT INTO public.participate_in VALUES (266, 188);
INSERT INTO public.participate_in VALUES (267, 156);
INSERT INTO public.participate_in VALUES (267, 179);
INSERT INTO public.participate_in VALUES (267, 42);
INSERT INTO public.participate_in VALUES (268, 105);
INSERT INTO public.participate_in VALUES (268, 131);
INSERT INTO public.participate_in VALUES (269, 89);
INSERT INTO public.participate_in VALUES (269, 146);
INSERT INTO public.participate_in VALUES (270, 31);
INSERT INTO public.participate_in VALUES (271, 105);
INSERT INTO public.participate_in VALUES (271, 151);
INSERT INTO public.participate_in VALUES (271, 46);
INSERT INTO public.participate_in VALUES (272, 193);
INSERT INTO public.participate_in VALUES (273, 46);
INSERT INTO public.participate_in VALUES (274, 140);
INSERT INTO public.participate_in VALUES (274, 55);
INSERT INTO public.participate_in VALUES (274, 77);
INSERT INTO public.participate_in VALUES (275, 91);
INSERT INTO public.participate_in VALUES (276, 32);
INSERT INTO public.participate_in VALUES (276, 96);
INSERT INTO public.participate_in VALUES (277, 198);
INSERT INTO public.participate_in VALUES (277, 133);
INSERT INTO public.participate_in VALUES (277, 179);
INSERT INTO public.participate_in VALUES (278, 87);
INSERT INTO public.participate_in VALUES (278, 34);
INSERT INTO public.participate_in VALUES (278, 132);
INSERT INTO public.participate_in VALUES (279, 184);
INSERT INTO public.participate_in VALUES (279, 150);
INSERT INTO public.participate_in VALUES (280, 72);
INSERT INTO public.participate_in VALUES (280, 55);
INSERT INTO public.participate_in VALUES (280, 8);
INSERT INTO public.participate_in VALUES (281, 67);
INSERT INTO public.participate_in VALUES (281, 65);
INSERT INTO public.participate_in VALUES (282, 70);
INSERT INTO public.participate_in VALUES (282, 44);
INSERT INTO public.participate_in VALUES (282, 137);
INSERT INTO public.participate_in VALUES (283, 43);
INSERT INTO public.participate_in VALUES (283, 122);
INSERT INTO public.participate_in VALUES (283, 31);
INSERT INTO public.participate_in VALUES (284, 75);
INSERT INTO public.participate_in VALUES (284, 114);
INSERT INTO public.participate_in VALUES (285, 49);
INSERT INTO public.participate_in VALUES (285, 126);
INSERT INTO public.participate_in VALUES (285, 167);
INSERT INTO public.participate_in VALUES (286, 43);
INSERT INTO public.participate_in VALUES (286, 132);
INSERT INTO public.participate_in VALUES (286, 70);
INSERT INTO public.participate_in VALUES (287, 16);
INSERT INTO public.participate_in VALUES (287, 139);
INSERT INTO public.participate_in VALUES (287, 145);
INSERT INTO public.participate_in VALUES (288, 24);
INSERT INTO public.participate_in VALUES (288, 44);
INSERT INTO public.participate_in VALUES (288, 64);
INSERT INTO public.participate_in VALUES (289, 176);
INSERT INTO public.participate_in VALUES (290, 35);
INSERT INTO public.participate_in VALUES (290, 129);
INSERT INTO public.participate_in VALUES (291, 171);
INSERT INTO public.participate_in VALUES (291, 197);
INSERT INTO public.participate_in VALUES (292, 189);
INSERT INTO public.participate_in VALUES (292, 6);
INSERT INTO public.participate_in VALUES (292, 32);
INSERT INTO public.participate_in VALUES (293, 27);
INSERT INTO public.participate_in VALUES (294, 30);
INSERT INTO public.participate_in VALUES (294, 21);
INSERT INTO public.participate_in VALUES (295, 166);
INSERT INTO public.participate_in VALUES (295, 11);
INSERT INTO public.participate_in VALUES (295, 34);
INSERT INTO public.participate_in VALUES (296, 164);
INSERT INTO public.participate_in VALUES (296, 16);
INSERT INTO public.participate_in VALUES (296, 103);
INSERT INTO public.participate_in VALUES (297, 106);
INSERT INTO public.participate_in VALUES (297, 3);
INSERT INTO public.participate_in VALUES (298, 60);
INSERT INTO public.participate_in VALUES (299, 22);
INSERT INTO public.participate_in VALUES (299, 200);
INSERT INTO public.participate_in VALUES (299, 126);
INSERT INTO public.participate_in VALUES (300, 21);
INSERT INTO public.participate_in VALUES (300, 19);
INSERT INTO public.participate_in VALUES (301, 192);
INSERT INTO public.participate_in VALUES (302, 184);
INSERT INTO public.participate_in VALUES (303, 59);
INSERT INTO public.participate_in VALUES (303, 126);
INSERT INTO public.participate_in VALUES (304, 45);
INSERT INTO public.participate_in VALUES (305, 9);
INSERT INTO public.participate_in VALUES (305, 97);
INSERT INTO public.participate_in VALUES (306, 5);
INSERT INTO public.participate_in VALUES (306, 148);
INSERT INTO public.participate_in VALUES (307, 200);
INSERT INTO public.participate_in VALUES (307, 19);
INSERT INTO public.participate_in VALUES (308, 86);
INSERT INTO public.participate_in VALUES (308, 58);
INSERT INTO public.participate_in VALUES (309, 30);
INSERT INTO public.participate_in VALUES (310, 180);
INSERT INTO public.participate_in VALUES (311, 191);
INSERT INTO public.participate_in VALUES (311, 149);
INSERT INTO public.participate_in VALUES (312, 73);
INSERT INTO public.participate_in VALUES (312, 87);
INSERT INTO public.participate_in VALUES (312, 186);
INSERT INTO public.participate_in VALUES (313, 173);
INSERT INTO public.participate_in VALUES (313, 6);
INSERT INTO public.participate_in VALUES (313, 98);
INSERT INTO public.participate_in VALUES (314, 63);
INSERT INTO public.participate_in VALUES (314, 189);
INSERT INTO public.participate_in VALUES (314, 118);
INSERT INTO public.participate_in VALUES (315, 113);
INSERT INTO public.participate_in VALUES (315, 49);
INSERT INTO public.participate_in VALUES (315, 28);
INSERT INTO public.participate_in VALUES (316, 15);
INSERT INTO public.participate_in VALUES (316, 16);
INSERT INTO public.participate_in VALUES (316, 36);
INSERT INTO public.participate_in VALUES (317, 119);
INSERT INTO public.participate_in VALUES (318, 38);
INSERT INTO public.participate_in VALUES (319, 19);
INSERT INTO public.participate_in VALUES (320, 128);
INSERT INTO public.participate_in VALUES (321, 83);
INSERT INTO public.participate_in VALUES (322, 130);
INSERT INTO public.participate_in VALUES (323, 21);
INSERT INTO public.participate_in VALUES (323, 76);
INSERT INTO public.participate_in VALUES (323, 112);
INSERT INTO public.participate_in VALUES (324, 106);
INSERT INTO public.participate_in VALUES (325, 10);
INSERT INTO public.participate_in VALUES (326, 93);
INSERT INTO public.participate_in VALUES (326, 97);
INSERT INTO public.participate_in VALUES (326, 64);
INSERT INTO public.participate_in VALUES (327, 36);
INSERT INTO public.participate_in VALUES (327, 141);
INSERT INTO public.participate_in VALUES (327, 60);
INSERT INTO public.participate_in VALUES (328, 112);
INSERT INTO public.participate_in VALUES (328, 133);
INSERT INTO public.participate_in VALUES (329, 79);
INSERT INTO public.participate_in VALUES (330, 143);
INSERT INTO public.participate_in VALUES (330, 33);
INSERT INTO public.participate_in VALUES (331, 78);
INSERT INTO public.participate_in VALUES (331, 20);
INSERT INTO public.participate_in VALUES (331, 126);
INSERT INTO public.participate_in VALUES (332, 15);
INSERT INTO public.participate_in VALUES (333, 163);
INSERT INTO public.participate_in VALUES (333, 15);
INSERT INTO public.participate_in VALUES (334, 47);
INSERT INTO public.participate_in VALUES (334, 189);
INSERT INTO public.participate_in VALUES (334, 120);
INSERT INTO public.participate_in VALUES (335, 72);
INSERT INTO public.participate_in VALUES (335, 56);
INSERT INTO public.participate_in VALUES (336, 82);
INSERT INTO public.participate_in VALUES (336, 184);
INSERT INTO public.participate_in VALUES (337, 91);
INSERT INTO public.participate_in VALUES (337, 130);
INSERT INTO public.participate_in VALUES (338, 71);
INSERT INTO public.participate_in VALUES (338, 65);
INSERT INTO public.participate_in VALUES (338, 122);
INSERT INTO public.participate_in VALUES (339, 127);
INSERT INTO public.participate_in VALUES (339, 168);
INSERT INTO public.participate_in VALUES (340, 135);
INSERT INTO public.participate_in VALUES (341, 108);
INSERT INTO public.participate_in VALUES (341, 156);
INSERT INTO public.participate_in VALUES (342, 97);
INSERT INTO public.participate_in VALUES (342, 28);
INSERT INTO public.participate_in VALUES (343, 24);
INSERT INTO public.participate_in VALUES (344, 14);
INSERT INTO public.participate_in VALUES (345, 11);
INSERT INTO public.participate_in VALUES (346, 70);
INSERT INTO public.participate_in VALUES (346, 73);
INSERT INTO public.participate_in VALUES (347, 132);
INSERT INTO public.participate_in VALUES (347, 125);
INSERT INTO public.participate_in VALUES (347, 172);
INSERT INTO public.participate_in VALUES (348, 132);
INSERT INTO public.participate_in VALUES (349, 170);
INSERT INTO public.participate_in VALUES (349, 55);
INSERT INTO public.participate_in VALUES (350, 151);
INSERT INTO public.participate_in VALUES (350, 169);
INSERT INTO public.participate_in VALUES (351, 28);
INSERT INTO public.participate_in VALUES (351, 39);
INSERT INTO public.participate_in VALUES (352, 156);
INSERT INTO public.participate_in VALUES (352, 157);
INSERT INTO public.participate_in VALUES (352, 184);
INSERT INTO public.participate_in VALUES (353, 91);
INSERT INTO public.participate_in VALUES (353, 187);
INSERT INTO public.participate_in VALUES (354, 71);
INSERT INTO public.participate_in VALUES (355, 111);
INSERT INTO public.participate_in VALUES (356, 191);
INSERT INTO public.participate_in VALUES (357, 49);
INSERT INTO public.participate_in VALUES (358, 182);
INSERT INTO public.participate_in VALUES (358, 50);
INSERT INTO public.participate_in VALUES (359, 154);
INSERT INTO public.participate_in VALUES (359, 179);
INSERT INTO public.participate_in VALUES (360, 108);
INSERT INTO public.participate_in VALUES (361, 6);
INSERT INTO public.participate_in VALUES (362, 167);
INSERT INTO public.participate_in VALUES (362, 118);
INSERT INTO public.participate_in VALUES (362, 178);
INSERT INTO public.participate_in VALUES (363, 141);
INSERT INTO public.participate_in VALUES (364, 99);
INSERT INTO public.participate_in VALUES (365, 64);
INSERT INTO public.participate_in VALUES (365, 143);
INSERT INTO public.participate_in VALUES (366, 18);
INSERT INTO public.participate_in VALUES (366, 68);
INSERT INTO public.participate_in VALUES (367, 33);
INSERT INTO public.participate_in VALUES (367, 129);
INSERT INTO public.participate_in VALUES (367, 7);
INSERT INTO public.participate_in VALUES (368, 8);
INSERT INTO public.participate_in VALUES (368, 109);
INSERT INTO public.participate_in VALUES (368, 12);
INSERT INTO public.participate_in VALUES (369, 47);
INSERT INTO public.participate_in VALUES (369, 28);
INSERT INTO public.participate_in VALUES (370, 199);
INSERT INTO public.participate_in VALUES (370, 184);
INSERT INTO public.participate_in VALUES (371, 92);
INSERT INTO public.participate_in VALUES (371, 153);
INSERT INTO public.participate_in VALUES (372, 129);
INSERT INTO public.participate_in VALUES (372, 37);
INSERT INTO public.participate_in VALUES (373, 66);
INSERT INTO public.participate_in VALUES (373, 154);
INSERT INTO public.participate_in VALUES (374, 171);
INSERT INTO public.participate_in VALUES (375, 59);
INSERT INTO public.participate_in VALUES (375, 172);
INSERT INTO public.participate_in VALUES (375, 33);
INSERT INTO public.participate_in VALUES (376, 162);
INSERT INTO public.participate_in VALUES (377, 186);
INSERT INTO public.participate_in VALUES (378, 134);
INSERT INTO public.participate_in VALUES (378, 28);
INSERT INTO public.participate_in VALUES (378, 141);
INSERT INTO public.participate_in VALUES (379, 144);
INSERT INTO public.participate_in VALUES (380, 198);
INSERT INTO public.participate_in VALUES (380, 89);
INSERT INTO public.participate_in VALUES (381, 15);
INSERT INTO public.participate_in VALUES (382, 112);
INSERT INTO public.participate_in VALUES (383, 108);
INSERT INTO public.participate_in VALUES (383, 177);
INSERT INTO public.participate_in VALUES (383, 14);
INSERT INTO public.participate_in VALUES (384, 11);
INSERT INTO public.participate_in VALUES (385, 37);
INSERT INTO public.participate_in VALUES (385, 19);
INSERT INTO public.participate_in VALUES (386, 195);
INSERT INTO public.participate_in VALUES (387, 165);
INSERT INTO public.participate_in VALUES (388, 32);
INSERT INTO public.participate_in VALUES (388, 11);
INSERT INTO public.participate_in VALUES (388, 69);
INSERT INTO public.participate_in VALUES (389, 97);
INSERT INTO public.participate_in VALUES (390, 87);
INSERT INTO public.participate_in VALUES (390, 73);
INSERT INTO public.participate_in VALUES (390, 83);
INSERT INTO public.participate_in VALUES (391, 67);
INSERT INTO public.participate_in VALUES (392, 41);
INSERT INTO public.participate_in VALUES (392, 74);
INSERT INTO public.participate_in VALUES (392, 199);
INSERT INTO public.participate_in VALUES (393, 91);
INSERT INTO public.participate_in VALUES (393, 189);
INSERT INTO public.participate_in VALUES (394, 42);
INSERT INTO public.participate_in VALUES (394, 60);
INSERT INTO public.participate_in VALUES (395, 24);
INSERT INTO public.participate_in VALUES (396, 48);
INSERT INTO public.participate_in VALUES (397, 153);
INSERT INTO public.participate_in VALUES (397, 93);
INSERT INTO public.participate_in VALUES (398, 103);
INSERT INTO public.participate_in VALUES (398, 154);
INSERT INTO public.participate_in VALUES (398, 111);
INSERT INTO public.participate_in VALUES (399, 78);
INSERT INTO public.participate_in VALUES (399, 96);
INSERT INTO public.participate_in VALUES (399, 76);
INSERT INTO public.participate_in VALUES (400, 146);


--
-- TOC entry 5078 (class 0 OID 17097)
-- Dependencies: 219
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person VALUES (1, 'Rebecca Bar', '1994-03-18', 'rebecca.bar1@email.com', '051-2142180');
INSERT INTO public.person VALUES (2, 'Adam Golan', '1990-12-20', 'adam.golan2@email.com', '059-1013581');
INSERT INTO public.person VALUES (3, 'Adam Shapiro', '1976-01-09', 'adam.shapiro3@email.com', '055-6630744');
INSERT INTO public.person VALUES (4, 'Benjamin Chen', '2010-02-18', 'benjamin.chen4@email.com', '054-6645286');
INSERT INTO public.person VALUES (5, 'Michael Stern', '1976-02-11', 'michael.stern5@email.com', '057-5163145');
INSERT INTO public.person VALUES (6, 'Leah Shapiro', '1986-07-08', 'leah.shapiro6@email.com', '055-1869768');
INSERT INTO public.person VALUES (7, 'Deborah Gil', '2010-05-23', 'deborah.gil7@email.com', '052-6102608');
INSERT INTO public.person VALUES (8, 'Shira Alon', '2006-09-16', 'shira.alon8@email.com', '054-1929245');
INSERT INTO public.person VALUES (9, 'Rebecca Alon', '1999-02-22', 'rebecca.alon9@email.com', '057-9625112');
INSERT INTO public.person VALUES (10, 'Michael Weiss', '1997-03-01', 'michael.weiss10@email.com', '053-3734437');
INSERT INTO public.person VALUES (11, 'Esther Avraham', '2009-07-15', 'esther.avraham11@email.com', '051-1784181');
INSERT INTO public.person VALUES (12, 'Isaac Katz', '1993-01-25', 'isaac.katz12@email.com', '055-7996075');
INSERT INTO public.person VALUES (13, 'Hannah Carmel', '1988-11-15', 'hannah.carmel13@email.com', '055-3312456');
INSERT INTO public.person VALUES (14, 'Tamar Bar', '1980-10-04', 'tamar.bar14@email.com', '051-3103461');
INSERT INTO public.person VALUES (15, 'Hannah Israeli', '2007-07-01', 'hannah.israeli15@email.com', '059-2339383');
INSERT INTO public.person VALUES (16, 'Yael Ben-Ami', '1998-10-22', 'yael.ben-ami16@email.com', '052-8282646');
INSERT INTO public.person VALUES (17, 'Samuel Israeli', '1977-09-19', 'samuel.israeli17@email.com', '059-2873521');
INSERT INTO public.person VALUES (18, 'Shira Mizrahi', '2010-04-14', 'shira.mizrahi18@email.com', '058-2762692');
INSERT INTO public.person VALUES (19, 'Isaac Avraham', '2004-06-20', 'isaac.avraham19@email.com', '051-5054231');
INSERT INTO public.person VALUES (20, 'Abigail Golan', '1990-04-13', 'abigail.golan20@email.com', '058-6922034');
INSERT INTO public.person VALUES (21, 'Yael Goldstein', '1992-05-11', 'yael.goldstein21@email.com', '054-5995056');
INSERT INTO public.person VALUES (22, 'Samuel Carmel', '1982-04-07', 'samuel.carmel22@email.com', '059-7474356');
INSERT INTO public.person VALUES (23, 'Tamar Katz', '1995-01-28', 'tamar.katz23@email.com', '057-2772919');
INSERT INTO public.person VALUES (24, 'Hannah Golan', '2001-09-19', 'hannah.golan24@email.com', '055-2528599');
INSERT INTO public.person VALUES (25, 'Aaron Cohen', '2008-03-26', 'aaron.cohen25@email.com', '054-1351906');
INSERT INTO public.person VALUES (26, 'Michael Cohen', '2000-11-12', 'michael.cohen26@email.com', '054-8884989');
INSERT INTO public.person VALUES (27, 'Eli Nir', '1978-06-30', 'eli.nir27@email.com', '052-9828694');
INSERT INTO public.person VALUES (28, 'Shira Golan', '1977-10-12', 'shira.golan28@email.com', '057-5011451');
INSERT INTO public.person VALUES (29, 'Daniel Galili', '2014-10-04', 'daniel.galili29@email.com', '055-2509704');
INSERT INTO public.person VALUES (30, 'Noah Zion', '1998-09-15', 'noah.zion30@email.com', '052-5459020');
INSERT INTO public.person VALUES (31, 'Rebecca Weiss', '2005-05-04', 'rebecca.weiss31@email.com', '058-9920996');
INSERT INTO public.person VALUES (32, 'Hannah Levi', '1998-07-09', 'hannah.levi32@email.com', '058-8967177');
INSERT INTO public.person VALUES (33, 'Rachel Katz', '2004-08-21', 'rachel.katz33@email.com', '050-5983170');
INSERT INTO public.person VALUES (34, 'Naomi Shapiro', '2000-04-14', 'naomi.shapiro34@email.com', '051-8586666');
INSERT INTO public.person VALUES (35, 'Eli Levi', '1990-05-09', 'eli.levi35@email.com', '058-1125976');
INSERT INTO public.person VALUES (36, 'Aaron Alon', '1980-02-21', 'aaron.alon36@email.com', '059-9640003');
INSERT INTO public.person VALUES (37, 'Shira Israeli', '1977-12-23', 'shira.israeli37@email.com', '058-8443029');
INSERT INTO public.person VALUES (38, 'Yael Carmel', '2014-11-14', 'yael.carmel38@email.com', '051-1556069');
INSERT INTO public.person VALUES (39, 'Esther Rosen', '2002-07-15', 'esther.rosen39@email.com', '056-7087249');
INSERT INTO public.person VALUES (40, 'Daniel Levy', '1993-07-11', 'daniel.levy40@email.com', '050-8352051');
INSERT INTO public.person VALUES (41, 'David Avraham', '1997-05-04', 'david.avraham41@email.com', '053-5773799');
INSERT INTO public.person VALUES (42, 'Hannah Klein', '1993-04-12', 'hannah.klein42@email.com', '053-1924985');
INSERT INTO public.person VALUES (43, 'Leah Klein', '2014-10-22', 'leah.klein43@email.com', '050-6859577');
INSERT INTO public.person VALUES (44, 'Aaron Sharon', '2015-02-17', 'aaron.sharon44@email.com', '055-5747156');
INSERT INTO public.person VALUES (45, 'Aaron Paz', '2010-10-21', 'aaron.paz45@email.com', '056-5643038');
INSERT INTO public.person VALUES (46, 'David Stern', '1987-01-13', 'david.stern46@email.com', '059-7407564');
INSERT INTO public.person VALUES (47, 'Miriam Israeli', '2001-07-04', 'miriam.israeli47@email.com', '059-1147104');
INSERT INTO public.person VALUES (48, 'Isaac Avraham', '1985-05-09', 'isaac.avraham48@email.com', '051-3221555');
INSERT INTO public.person VALUES (49, 'Adam Goldstein', '1979-08-14', 'adam.goldstein49@email.com', '053-2830276');
INSERT INTO public.person VALUES (50, 'Leah Alon', '1978-10-07', 'leah.alon50@email.com', '058-4087773');
INSERT INTO public.person VALUES (51, 'Ethan Avraham', '1999-02-11', 'ethan.avraham51@email.com', '056-2825638');
INSERT INTO public.person VALUES (52, 'Yael Mizrahi', '1996-05-16', 'yael.mizrahi52@email.com', '051-7761740');
INSERT INTO public.person VALUES (53, 'Naomi Paz', '1995-10-18', 'naomi.paz53@email.com', '055-8361540');
INSERT INTO public.person VALUES (54, 'Abigail Goldstein', '2002-07-15', 'abigail.goldstein54@email.com', '052-5161781');
INSERT INTO public.person VALUES (55, 'Adam Friedman', '1983-04-05', 'adam.friedman55@email.com', '059-2465455');
INSERT INTO public.person VALUES (56, 'Avi Friedman', '1993-07-21', 'avi.friedman56@email.com', '054-2330829');
INSERT INTO public.person VALUES (57, 'Joshua Nir', '1988-08-04', 'joshua.nir57@email.com', '053-8083518');
INSERT INTO public.person VALUES (58, 'Esther Levi', '1978-09-13', 'esther.levi58@email.com', '056-8257208');
INSERT INTO public.person VALUES (59, 'Michael Peretz', '2002-05-06', 'michael.peretz59@email.com', '056-8268121');
INSERT INTO public.person VALUES (60, 'Aaron Levi', '2010-06-17', 'aaron.levi60@email.com', '053-9154178');
INSERT INTO public.person VALUES (61, 'Michael Nir', '1991-09-23', 'michael.nir61@email.com', '050-3352829');
INSERT INTO public.person VALUES (62, 'Avi Stern', '2011-02-16', 'avi.stern62@email.com', '058-1742110');
INSERT INTO public.person VALUES (63, 'Miriam Gil', '1986-03-19', 'miriam.gil63@email.com', '050-5121023');
INSERT INTO public.person VALUES (64, 'Aaron Rosen', '1983-03-14', 'aaron.rosen64@email.com', '058-6144930');
INSERT INTO public.person VALUES (65, 'Samuel Bar', '2012-04-06', 'samuel.bar65@email.com', '055-4515361');
INSERT INTO public.person VALUES (66, 'Joshua Davidov', '1998-08-22', 'joshua.davidov66@email.com', '051-1730391');
INSERT INTO public.person VALUES (67, 'Leah Davidov', '2000-02-01', 'leah.davidov67@email.com', '053-6654987');
INSERT INTO public.person VALUES (68, 'Benjamin Or', '2000-10-14', 'benjamin.or68@email.com', '054-3906750');
INSERT INTO public.person VALUES (69, 'Adam Tal', '1979-06-14', 'adam.tal69@email.com', '050-2480438');
INSERT INTO public.person VALUES (70, 'Benjamin Mizrahi', '1981-10-28', 'benjamin.mizrahi70@email.com', '053-7130175');
INSERT INTO public.person VALUES (71, 'Benjamin Cohen', '2006-02-18', 'benjamin.cohen71@email.com', '053-5192781');
INSERT INTO public.person VALUES (72, 'Yael Or', '1997-05-18', 'yael.or72@email.com', '058-2530990');
INSERT INTO public.person VALUES (73, 'Noah Davidov', '1991-01-23', 'noah.davidov73@email.com', '055-3233264');
INSERT INTO public.person VALUES (74, 'Miriam Katz', '1994-03-19', 'miriam.katz74@email.com', '053-6252665');
INSERT INTO public.person VALUES (75, 'Ruth Sharon', '2002-06-06', 'ruth.sharon75@email.com', '058-7510531');
INSERT INTO public.person VALUES (76, 'Shira Avraham', '1989-04-18', 'shira.avraham76@email.com', '056-3402834');
INSERT INTO public.person VALUES (77, 'Joshua Bar', '1977-10-15', 'joshua.bar77@email.com', '058-3198084');
INSERT INTO public.person VALUES (78, 'Yael Davidov', '1977-07-24', 'yael.davidov78@email.com', '057-4221025');
INSERT INTO public.person VALUES (79, 'Leah Israeli', '2015-01-19', 'leah.israeli79@email.com', '059-1239953');
INSERT INTO public.person VALUES (80, 'Hannah Levi', '2015-11-02', 'hannah.levi80@email.com', '054-9064037');
INSERT INTO public.person VALUES (81, 'Jacob Stern', '1999-09-05', 'jacob.stern81@email.com', '058-3794416');
INSERT INTO public.person VALUES (82, 'Daniel Klein', '1986-02-10', 'daniel.klein82@email.com', '052-3862950');
INSERT INTO public.person VALUES (83, 'Daniel Levi', '2005-09-28', 'daniel.levi83@email.com', '059-8517007');
INSERT INTO public.person VALUES (84, 'Naomi Shapiro', '1997-04-11', 'naomi.shapiro84@email.com', '054-6639891');
INSERT INTO public.person VALUES (85, 'Maya Galili', '2003-04-03', 'maya.galili85@email.com', '057-1774184');
INSERT INTO public.person VALUES (86, 'Jacob Golan', '1989-06-20', 'jacob.golan86@email.com', '053-4515627');
INSERT INTO public.person VALUES (87, 'Aaron Nir', '1989-04-23', 'aaron.nir87@email.com', '053-5245096');
INSERT INTO public.person VALUES (88, 'Rachel Friedman', '1999-06-23', 'rachel.friedman88@email.com', '052-2197842');
INSERT INTO public.person VALUES (89, 'Shira Avraham', '1976-08-25', 'shira.avraham89@email.com', '058-7677214');
INSERT INTO public.person VALUES (90, 'Ethan Weiss', '2015-12-05', 'ethan.weiss90@email.com', '053-3264209');
INSERT INTO public.person VALUES (91, 'Isaac Stern', '1999-07-25', 'isaac.stern91@email.com', '051-8239046');
INSERT INTO public.person VALUES (92, 'Abigail Tal', '2012-01-05', 'abigail.tal92@email.com', '051-7048904');
INSERT INTO public.person VALUES (93, 'Avi Or', '1985-07-06', 'avi.or93@email.com', '052-5934562');
INSERT INTO public.person VALUES (94, 'Joseph Peretz', '1990-12-16', 'joseph.peretz94@email.com', '055-8739377');
INSERT INTO public.person VALUES (95, 'Aaron Goldstein', '2002-11-26', 'aaron.goldstein95@email.com', '057-5013236');
INSERT INTO public.person VALUES (96, 'David Levi', '2007-08-29', 'david.levi96@email.com', '054-1271996');
INSERT INTO public.person VALUES (97, 'Tamar Sharon', '1982-12-05', 'tamar.sharon97@email.com', '051-3509145');
INSERT INTO public.person VALUES (98, 'Ethan Cohen', '2015-07-16', 'ethan.cohen98@email.com', '051-7867498');
INSERT INTO public.person VALUES (99, 'Jacob Galili', '1986-05-31', 'jacob.galili99@email.com', '052-7990746');
INSERT INTO public.person VALUES (100, 'Aaron Levi', '2012-12-16', 'aaron.levi100@email.com', '050-6403397');
INSERT INTO public.person VALUES (101, 'Avi Zion', '2007-05-03', 'avi.zion101@email.com', '050-7434963');
INSERT INTO public.person VALUES (102, 'Eli Golan', '2007-12-05', 'eli.golan102@email.com', '057-6257195');
INSERT INTO public.person VALUES (103, 'Adam Israeli', '2010-11-18', 'adam.israeli103@email.com', '050-4175575');
INSERT INTO public.person VALUES (104, 'Shira Weiss', '2005-05-06', 'shira.weiss104@email.com', '054-1092134');
INSERT INTO public.person VALUES (105, 'Samuel Friedman', '1979-08-18', 'samuel.friedman105@email.com', '051-7421444');
INSERT INTO public.person VALUES (106, 'Adam Shapiro', '1984-08-25', 'adam.shapiro106@email.com', '057-7549147');
INSERT INTO public.person VALUES (107, 'Joshua Nir', '2009-02-20', 'joshua.nir107@email.com', '051-1312874');
INSERT INTO public.person VALUES (108, 'Benjamin Stern', '1980-03-21', 'benjamin.stern108@email.com', '057-4591024');
INSERT INTO public.person VALUES (109, 'David Golan', '1995-12-15', 'david.golan109@email.com', '053-6479742');
INSERT INTO public.person VALUES (110, 'David Cohen', '1989-08-26', 'david.cohen110@email.com', '051-8232046');
INSERT INTO public.person VALUES (111, 'Esther Weiss', '2009-10-09', 'esther.weiss111@email.com', '050-7934852');
INSERT INTO public.person VALUES (112, 'Yael Alon', '1978-07-06', 'yael.alon112@email.com', '054-4898869');
INSERT INTO public.person VALUES (113, 'Ruth Tal', '2007-09-22', 'ruth.tal113@email.com', '051-4336519');
INSERT INTO public.person VALUES (114, 'Miriam Katz', '1999-07-09', 'miriam.katz114@email.com', '052-5059733');
INSERT INTO public.person VALUES (115, 'Esther Levy', '1995-09-05', 'esther.levy115@email.com', '050-2745373');
INSERT INTO public.person VALUES (116, 'Adam Israeli', '1979-03-14', 'adam.israeli116@email.com', '053-3080217');
INSERT INTO public.person VALUES (117, 'Esther Mizrahi', '2004-02-10', 'esther.mizrahi117@email.com', '055-3075604');
INSERT INTO public.person VALUES (118, 'Esther Katz', '1994-06-21', 'esther.katz118@email.com', '058-6996025');
INSERT INTO public.person VALUES (119, 'Hannah Chen', '2000-01-16', 'hannah.chen119@email.com', '059-2469156');
INSERT INTO public.person VALUES (120, 'Noah Goldstein', '1996-05-29', 'noah.goldstein120@email.com', '051-1903297');
INSERT INTO public.person VALUES (121, 'Michael Rosen', '1975-04-25', 'michael.rosen121@email.com', '052-4294356');
INSERT INTO public.person VALUES (122, 'Naomi Klein', '1981-02-14', 'naomi.klein122@email.com', '057-4432128');
INSERT INTO public.person VALUES (123, 'Eli Zion', '1985-09-24', 'eli.zion123@email.com', '052-7838711');
INSERT INTO public.person VALUES (124, 'Adam Alon', '2015-02-12', 'adam.alon124@email.com', '053-1657356');
INSERT INTO public.person VALUES (125, 'Eli Zion', '2006-09-12', 'eli.zion125@email.com', '050-1615298');
INSERT INTO public.person VALUES (126, 'Rachel Paz', '2013-09-12', 'rachel.paz126@email.com', '050-2399129');
INSERT INTO public.person VALUES (127, 'David Levi', '1997-11-21', 'david.levi127@email.com', '054-2647556');
INSERT INTO public.person VALUES (128, 'Maya Golan', '1993-11-01', 'maya.golan128@email.com', '057-5790581');
INSERT INTO public.person VALUES (129, 'Maya Gil', '1997-03-04', 'maya.gil129@email.com', '053-2975608');
INSERT INTO public.person VALUES (130, 'Rebecca Peretz', '2007-02-13', 'rebecca.peretz130@email.com', '056-8766233');
INSERT INTO public.person VALUES (131, 'Yael Carmel', '1982-04-02', 'yael.carmel131@email.com', '055-5686380');
INSERT INTO public.person VALUES (132, 'Shira Nir', '2004-06-27', 'shira.nir132@email.com', '057-1833912');
INSERT INTO public.person VALUES (133, 'Michael Weiss', '2004-12-08', 'michael.weiss133@email.com', '058-9347533');
INSERT INTO public.person VALUES (134, 'Joshua Weiss', '2010-11-06', 'joshua.weiss134@email.com', '052-1924594');
INSERT INTO public.person VALUES (135, 'Maya Avraham', '1983-04-14', 'maya.avraham135@email.com', '058-2410628');
INSERT INTO public.person VALUES (136, 'Sarah Rosen', '2001-02-07', 'sarah.rosen136@email.com', '051-9261717');
INSERT INTO public.person VALUES (137, 'Miriam Paz', '1987-05-17', 'miriam.paz137@email.com', '052-3391894');
INSERT INTO public.person VALUES (138, 'Abigail Avraham', '1975-09-24', 'abigail.avraham138@email.com', '053-7923935');
INSERT INTO public.person VALUES (139, 'Isaac Paz', '1998-11-03', 'isaac.paz139@email.com', '056-4858967');
INSERT INTO public.person VALUES (140, 'Rebecca Weiss', '2000-10-22', 'rebecca.weiss140@email.com', '051-6571454');
INSERT INTO public.person VALUES (141, 'Deborah Israeli', '1978-12-08', 'deborah.israeli141@email.com', '053-4978390');
INSERT INTO public.person VALUES (142, 'Shira Nir', '1981-02-12', 'shira.nir142@email.com', '056-5292273');
INSERT INTO public.person VALUES (143, 'Benjamin Alon', '1980-02-01', 'benjamin.alon143@email.com', '055-6393314');
INSERT INTO public.person VALUES (144, 'Naomi Levi', '1975-08-25', 'naomi.levi144@email.com', '055-4023363');
INSERT INTO public.person VALUES (145, 'Leah Galili', '1980-02-23', 'leah.galili145@email.com', '052-3632573');
INSERT INTO public.person VALUES (146, 'Ethan Davidov', '2010-06-18', 'ethan.davidov146@email.com', '057-6917857');
INSERT INTO public.person VALUES (147, 'Joshua Levi', '1992-06-02', 'joshua.levi147@email.com', '053-8374390');
INSERT INTO public.person VALUES (148, 'Abigail Katz', '1982-07-13', 'abigail.katz148@email.com', '057-4902228');
INSERT INTO public.person VALUES (149, 'Tamar Peretz', '1975-06-25', 'tamar.peretz149@email.com', '055-9902536');
INSERT INTO public.person VALUES (150, 'Aaron Tal', '1984-10-27', 'aaron.tal150@email.com', '050-9899987');
INSERT INTO public.person VALUES (151, 'Avi Klein', '1992-03-14', 'avi.klein151@email.com', '059-3371367');
INSERT INTO public.person VALUES (152, 'Hannah Or', '2013-11-11', 'hannah.or152@email.com', '054-6701450');
INSERT INTO public.person VALUES (153, 'Aaron Galili', '2004-03-08', 'aaron.galili153@email.com', '055-2405491');
INSERT INTO public.person VALUES (154, 'Esther Cohen', '1986-08-14', 'esther.cohen154@email.com', '051-3064875');
INSERT INTO public.person VALUES (155, 'Joseph Tal', '1983-11-15', 'joseph.tal155@email.com', '054-8912560');
INSERT INTO public.person VALUES (156, 'Esther Carmel', '2003-04-13', 'esther.carmel156@email.com', '057-4377952');
INSERT INTO public.person VALUES (157, 'Shira Mizrahi', '1985-09-08', 'shira.mizrahi157@email.com', '056-2361729');
INSERT INTO public.person VALUES (158, 'Hannah Levi', '2007-06-13', 'hannah.levi158@email.com', '057-5043121');
INSERT INTO public.person VALUES (159, 'Tamar Rosen', '2008-02-03', 'tamar.rosen159@email.com', '050-3538452');
INSERT INTO public.person VALUES (160, 'Ethan Weiss', '1983-07-28', 'ethan.weiss160@email.com', '056-6212015');
INSERT INTO public.person VALUES (161, 'Benjamin Carmel', '2004-08-28', 'benjamin.carmel161@email.com', '052-6110231');
INSERT INTO public.person VALUES (162, 'Rebecca Peretz', '1979-10-30', 'rebecca.peretz162@email.com', '057-2266342');
INSERT INTO public.person VALUES (163, 'Adam Bar', '1988-05-20', 'adam.bar163@email.com', '053-6904260');
INSERT INTO public.person VALUES (164, 'Michael Shapiro', '2003-02-24', 'michael.shapiro164@email.com', '057-8428866');
INSERT INTO public.person VALUES (165, 'Joshua Sharon', '1990-05-21', 'joshua.sharon165@email.com', '050-5696751');
INSERT INTO public.person VALUES (166, 'Deborah Avraham', '2001-12-06', 'deborah.avraham166@email.com', '052-2062966');
INSERT INTO public.person VALUES (167, 'Eli Cohen', '2014-05-22', 'eli.cohen167@email.com', '053-1645996');
INSERT INTO public.person VALUES (168, 'Shira Weiss', '2011-09-28', 'shira.weiss168@email.com', '059-6748340');
INSERT INTO public.person VALUES (169, 'Joseph Weiss', '1981-06-24', 'joseph.weiss169@email.com', '050-7741293');
INSERT INTO public.person VALUES (170, 'Noah Chen', '2013-05-12', 'noah.chen170@email.com', '058-3063858');
INSERT INTO public.person VALUES (171, 'Jacob Levi', '1976-04-11', 'jacob.levi171@email.com', '053-5614031');
INSERT INTO public.person VALUES (172, 'Maya Rosen', '1994-11-05', 'maya.rosen172@email.com', '051-1310515');
INSERT INTO public.person VALUES (173, 'Abigail Bar', '2006-12-30', 'abigail.bar173@email.com', '059-4984085');
INSERT INTO public.person VALUES (174, 'Sarah Tal', '1990-12-14', 'sarah.tal174@email.com', '058-1598692');
INSERT INTO public.person VALUES (175, 'Leah Rosen', '2011-04-17', 'leah.rosen175@email.com', '059-4994017');
INSERT INTO public.person VALUES (176, 'Miriam Zion', '2009-06-11', 'miriam.zion176@email.com', '057-3774620');
INSERT INTO public.person VALUES (177, 'Avi Mizrahi', '1994-08-21', 'avi.mizrahi177@email.com', '053-1349319');
INSERT INTO public.person VALUES (178, 'Abigail Rosen', '1985-02-21', 'abigail.rosen178@email.com', '051-7086443');
INSERT INTO public.person VALUES (179, 'Noah Davidov', '1979-01-04', 'noah.davidov179@email.com', '056-8179741');
INSERT INTO public.person VALUES (180, 'Naomi Weiss', '2005-11-30', 'naomi.weiss180@email.com', '059-2332102');
INSERT INTO public.person VALUES (181, 'Joseph Levi', '1978-11-04', 'joseph.levi181@email.com', '054-7672594');
INSERT INTO public.person VALUES (182, 'Shira Katz', '1983-10-02', 'shira.katz182@email.com', '055-7624920');
INSERT INTO public.person VALUES (183, 'Adam Levy', '1996-03-28', 'adam.levy183@email.com', '054-5428958');
INSERT INTO public.person VALUES (184, 'Jacob Goldstein', '1989-11-17', 'jacob.goldstein184@email.com', '057-6699743');
INSERT INTO public.person VALUES (185, 'Benjamin Weiss', '1976-10-28', 'benjamin.weiss185@email.com', '051-4664884');
INSERT INTO public.person VALUES (186, 'Joshua Rosen', '1999-02-18', 'joshua.rosen186@email.com', '055-2576744');
INSERT INTO public.person VALUES (187, 'Daniel Shapiro', '1997-02-15', 'daniel.shapiro187@email.com', '053-6756526');
INSERT INTO public.person VALUES (188, 'Abigail Rosen', '1986-01-08', 'abigail.rosen188@email.com', '053-7184896');
INSERT INTO public.person VALUES (189, 'Isaac Nir', '1981-04-10', 'isaac.nir189@email.com', '053-7026101');
INSERT INTO public.person VALUES (190, 'Aaron Shapiro', '1993-09-28', 'aaron.shapiro190@email.com', '053-7388570');
INSERT INTO public.person VALUES (191, 'Maya Klein', '2000-06-07', 'maya.klein191@email.com', '052-5027837');
INSERT INTO public.person VALUES (192, 'Maya Alon', '2011-12-12', 'maya.alon192@email.com', '059-4176137');
INSERT INTO public.person VALUES (193, 'Ruth Alon', '2014-03-17', 'ruth.alon193@email.com', '052-6454132');
INSERT INTO public.person VALUES (194, 'Ruth Zion', '1996-03-08', 'ruth.zion194@email.com', '052-2516587');
INSERT INTO public.person VALUES (195, 'Sarah Nir', '2011-03-18', 'sarah.nir195@email.com', '056-9849756');
INSERT INTO public.person VALUES (196, 'Daniel Shapiro', '2011-08-07', 'daniel.shapiro196@email.com', '056-1336031');
INSERT INTO public.person VALUES (197, 'Maya Nir', '1986-12-17', 'maya.nir197@email.com', '053-6348170');
INSERT INTO public.person VALUES (198, 'Yael Galili', '1977-01-05', 'yael.galili198@email.com', '059-5577143');
INSERT INTO public.person VALUES (199, 'Ruth Gil', '1994-02-19', 'ruth.gil199@email.com', '053-5089020');
INSERT INTO public.person VALUES (200, 'Samuel Davidov', '1978-06-19', 'samuel.davidov200@email.com', '051-9437490');
INSERT INTO public.person VALUES (201, 'Aaron Golan', '2011-12-13', 'aaron.golan201@email.com', '052-4234447');
INSERT INTO public.person VALUES (202, 'Deborah Tal', '2013-10-05', 'deborah.tal202@email.com', '058-6178192');
INSERT INTO public.person VALUES (203, 'Avraham Friedman', '2010-02-06', 'avraham.friedman203@email.com', '053-7328742');
INSERT INTO public.person VALUES (204, 'Esther Katz', '2013-02-18', 'esther.katz204@email.com', '058-4728019');
INSERT INTO public.person VALUES (205, 'Ethan Mizrahi', '2005-03-10', 'ethan.mizrahi205@email.com', '052-8312159');
INSERT INTO public.person VALUES (206, 'Avraham Katz', '2012-12-06', 'avraham.katz206@email.com', '050-8490851');
INSERT INTO public.person VALUES (207, 'Yael Davidov', '2015-09-08', 'yael.davidov207@email.com', '058-9777437');
INSERT INTO public.person VALUES (208, 'Deborah Stern', '2008-03-18', 'deborah.stern208@email.com', '050-5457326');
INSERT INTO public.person VALUES (209, 'Leah Bar', '2015-06-28', 'leah.bar209@email.com', '058-9180231');
INSERT INTO public.person VALUES (210, 'Daniel Avraham', '2005-03-08', 'daniel.avraham210@email.com', '050-7834417');
INSERT INTO public.person VALUES (211, 'Naomi Tal', '2009-12-10', 'naomi.tal211@email.com', '058-8673508');
INSERT INTO public.person VALUES (212, 'Maya Or', '2010-10-21', 'maya.or212@email.com', '050-5969447');
INSERT INTO public.person VALUES (213, 'Avi Rosen', '2011-05-17', 'avi.rosen213@email.com', '050-1362287');
INSERT INTO public.person VALUES (214, 'Esther Levi', '2018-06-29', 'esther.levi214@email.com', '058-3806352');
INSERT INTO public.person VALUES (215, 'Benjamin Paz', '2015-11-13', 'benjamin.paz215@email.com', '058-6992021');
INSERT INTO public.person VALUES (216, 'Samuel Mizrahi', '2011-01-25', 'samuel.mizrahi216@email.com', '050-2312538');
INSERT INTO public.person VALUES (217, 'Yaakov Levy', '2007-11-19', 'yaakov.levy217@email.com', '055-7949506');
INSERT INTO public.person VALUES (218, 'Sarah Avraham', '2015-11-03', 'sarah.avraham218@email.com', '058-3286864');
INSERT INTO public.person VALUES (219, 'Abigail Raz', '2018-01-02', 'abigail.raz219@email.com', '055-9321290');
INSERT INTO public.person VALUES (220, 'Tamar Raz', '2009-05-30', 'tamar.raz220@email.com', '050-6024174');
INSERT INTO public.person VALUES (221, 'Daniel Ben-Ami', '2017-08-18', 'daniel.ben-ami221@email.com', '055-3429653');
INSERT INTO public.person VALUES (222, 'Sarah Bar', '2010-02-16', 'sarah.bar222@email.com', '058-9767831');
INSERT INTO public.person VALUES (223, 'Sarah Or', '2005-09-12', 'sarah.or223@email.com', '050-5455036');
INSERT INTO public.person VALUES (224, 'Yael Or', '2010-06-06', 'yael.or224@email.com', '053-6770748');
INSERT INTO public.person VALUES (225, 'Miriam Mor', '2013-10-17', 'miriam.mor225@email.com', '053-7918963');
INSERT INTO public.person VALUES (226, 'Naomi Levi', '2012-11-16', 'naomi.levi226@email.com', '050-6199248');
INSERT INTO public.person VALUES (227, 'Dina Or', '2005-09-18', 'dina.or227@email.com', '054-9039894');
INSERT INTO public.person VALUES (228, 'Abigail Chen', '2017-10-01', 'abigail.chen228@email.com', '054-6433196');
INSERT INTO public.person VALUES (229, 'Rebecca Shapiro', '2016-07-05', 'rebecca.shapiro229@email.com', '052-1260178');
INSERT INTO public.person VALUES (230, 'Ruth Zion', '2011-01-18', 'ruth.zion230@email.com', '055-8861973');
INSERT INTO public.person VALUES (231, 'Rebecca Ben-Ami', '2007-10-31', 'rebecca.ben-ami231@email.com', '055-2452547');
INSERT INTO public.person VALUES (232, 'Sara Klein', '2014-08-01', 'sara.klein232@email.com', '054-2997219');
INSERT INTO public.person VALUES (233, 'Noah Chen', '2018-11-24', 'noah.chen233@email.com', '053-9292547');
INSERT INTO public.person VALUES (234, 'Noah Weiss', '2018-07-02', 'noah.weiss234@email.com', '054-6924296');
INSERT INTO public.person VALUES (235, 'Jacob Cohen', '2018-11-08', 'jacob.cohen235@email.com', '053-9900767');
INSERT INTO public.person VALUES (236, 'Isaac Gal', '2017-08-31', 'isaac.gal236@email.com', '054-9825319');
INSERT INTO public.person VALUES (237, 'Isaac Or', '2018-05-03', 'isaac.or237@email.com', '050-6882142');
INSERT INTO public.person VALUES (238, 'Yael Oren', '2017-04-17', 'yael.oren238@email.com', '058-2122999');
INSERT INTO public.person VALUES (239, 'Aaron Goldstein', '2016-10-04', 'aaron.goldstein239@email.com', '053-1845853');
INSERT INTO public.person VALUES (240, 'Eli Alon', '2010-10-09', 'eli.alon240@email.com', '058-2348324');
INSERT INTO public.person VALUES (241, 'Hannah Tal', '2017-06-01', 'hannah.tal241@email.com', '053-6684152');
INSERT INTO public.person VALUES (242, 'Deborah Klein', '2015-04-12', 'deborah.klein242@email.com', '052-8462264');
INSERT INTO public.person VALUES (243, 'Tova Raz', '2011-10-07', 'tova.raz243@email.com', '055-9871016');
INSERT INTO public.person VALUES (244, 'Rachel Zion', '2012-06-13', 'rachel.zion244@email.com', '050-8867315');
INSERT INTO public.person VALUES (245, 'Tova Bar', '2010-03-24', 'tova.bar245@email.com', '050-2969279');
INSERT INTO public.person VALUES (246, 'Dina Tal', '2008-01-23', 'dina.tal246@email.com', '050-7190576');
INSERT INTO public.person VALUES (247, 'Shira Israeli', '2008-11-28', 'shira.israeli247@email.com', '055-1046460');
INSERT INTO public.person VALUES (248, 'Yitzchak Golan', '2015-03-05', 'yitzchak.golan248@email.com', '050-5040035');
INSERT INTO public.person VALUES (249, 'Adam Cohen', '2007-04-14', 'adam.cohen249@email.com', '053-5078182');
INSERT INTO public.person VALUES (250, 'Ethan Nir', '2014-01-03', 'ethan.nir250@email.com', '052-9884395');
INSERT INTO public.person VALUES (251, 'Yosef Nir', '2015-06-21', 'yosef.nir251@email.com', '055-1380169');
INSERT INTO public.person VALUES (252, 'Adam Sharon', '2013-09-25', 'adam.sharon252@email.com', '055-8696036');
INSERT INTO public.person VALUES (253, 'Miriam Gil', '2011-01-23', 'miriam.gil253@email.com', '054-4731729');
INSERT INTO public.person VALUES (254, 'Malka Weiss', '2015-11-13', 'malka.weiss254@email.com', '054-1532896');
INSERT INTO public.person VALUES (255, 'Joseph Zion', '2014-04-12', 'joseph.zion255@email.com', '050-4157168');
INSERT INTO public.person VALUES (256, 'Benjamin Israeli', '2014-01-21', 'benjamin.israeli256@email.com', '058-8361055');
INSERT INTO public.person VALUES (257, 'Dina Carmel', '2010-10-26', 'dina.carmel257@email.com', '052-8127624');
INSERT INTO public.person VALUES (258, 'Joshua Stern', '2011-10-08', 'joshua.stern258@email.com', '055-8465698');
INSERT INTO public.person VALUES (259, 'Yael Stern', '2011-08-20', 'yael.stern259@email.com', '055-9699781');
INSERT INTO public.person VALUES (260, 'Noah Chen', '2009-09-15', 'noah.chen260@email.com', '054-8639385');
INSERT INTO public.person VALUES (261, 'Joshua Shapiro', '2016-01-07', 'joshua.shapiro261@email.com', '055-5303243');
INSERT INTO public.person VALUES (262, 'Samuel Cohen', '2010-05-10', 'samuel.cohen262@email.com', '055-5644293');
INSERT INTO public.person VALUES (263, 'Tova Or', '2015-09-14', 'tova.or263@email.com', '054-2416333');
INSERT INTO public.person VALUES (264, 'Daniel Israeli', '2013-10-26', 'daniel.israeli264@email.com', '050-9896140');
INSERT INTO public.person VALUES (265, 'Maya Or', '2015-05-09', 'maya.or265@email.com', '054-9292144');
INSERT INTO public.person VALUES (266, 'Esther Ben-Ami', '2015-04-30', 'esther.ben-ami266@email.com', '055-9091956');
INSERT INTO public.person VALUES (267, 'Moshe Cohen', '2015-01-21', 'moshe.cohen267@email.com', '052-3653187');
INSERT INTO public.person VALUES (268, 'Yael Levy', '2010-10-13', 'yael.levy268@email.com', '050-4820178');
INSERT INTO public.person VALUES (269, 'Aaron Peretz', '2012-04-12', 'aaron.peretz269@email.com', '052-8385828');
INSERT INTO public.person VALUES (270, 'Sarah Stern', '2013-10-09', 'sarah.stern270@email.com', '058-4322852');
INSERT INTO public.person VALUES (271, 'Hannah Friedman', '2008-03-02', 'hannah.friedman271@email.com', '058-6693408');
INSERT INTO public.person VALUES (272, 'Tamar Gil', '2011-12-06', 'tamar.gil272@email.com', '052-3225954');
INSERT INTO public.person VALUES (273, 'David Chen', '2011-12-21', 'david.chen273@email.com', '055-4858820');
INSERT INTO public.person VALUES (274, 'Moshe Tal', '2013-02-05', 'moshe.tal274@email.com', '050-8339107');
INSERT INTO public.person VALUES (275, 'Isaac Chen', '2011-07-05', 'isaac.chen275@email.com', '050-9465464');
INSERT INTO public.person VALUES (276, 'Tamar Gil', '2014-02-19', 'tamar.gil276@email.com', '050-7277907');
INSERT INTO public.person VALUES (277, 'Rivka Rosen', '2018-12-10', 'rivka.rosen277@email.com', '053-4418553');
INSERT INTO public.person VALUES (278, 'Rachel Israeli', '2016-04-26', 'rachel.israeli278@email.com', '058-5990422');
INSERT INTO public.person VALUES (279, 'Joshua Galili', '2017-12-31', 'joshua.galili279@email.com', '058-1986908');
INSERT INTO public.person VALUES (280, 'Shira Oren', '2015-10-31', 'shira.oren280@email.com', '050-1390347');
INSERT INTO public.person VALUES (281, 'Deborah Israeli', '2015-10-12', 'deborah.israeli281@email.com', '055-6583403');
INSERT INTO public.person VALUES (282, 'Yaakov Gal', '2016-02-17', 'yaakov.gal282@email.com', '055-7516894');
INSERT INTO public.person VALUES (283, 'Samuel Tal', '2012-12-07', 'samuel.tal283@email.com', '050-8167554');
INSERT INTO public.person VALUES (284, 'David Raz', '2010-04-30', 'david.raz284@email.com', '053-3182651');
INSERT INTO public.person VALUES (285, 'Chana Carmel', '2017-08-24', 'chana.carmel285@email.com', '052-9385157');
INSERT INTO public.person VALUES (286, 'Ethan Bar', '2015-03-21', 'ethan.bar286@email.com', '050-8999716');
INSERT INTO public.person VALUES (287, 'Shira Zion', '2014-04-19', 'shira.zion287@email.com', '058-2789913');
INSERT INTO public.person VALUES (288, 'Jacob Eitan', '2006-11-24', 'jacob.eitan288@email.com', '050-4087222');
INSERT INTO public.person VALUES (289, 'Avi Oren', '2014-03-26', 'avi.oren289@email.com', '058-5180349');
INSERT INTO public.person VALUES (290, 'Dina Chen', '2015-04-10', 'dina.chen290@email.com', '058-9264865');
INSERT INTO public.person VALUES (291, 'Sara Avraham', '2007-02-09', 'sara.avraham291@email.com', '058-4687845');
INSERT INTO public.person VALUES (292, 'Rachel Chen', '2014-10-01', 'rachel.chen292@email.com', '050-5117263');
INSERT INTO public.person VALUES (293, 'Joshua Mor', '2007-03-06', 'joshua.mor293@email.com', '058-7739469');
INSERT INTO public.person VALUES (294, 'Eli Friedman', '2009-06-01', 'eli.friedman294@email.com', '050-4804375');
INSERT INTO public.person VALUES (295, 'Abigail Gil', '2008-04-20', 'abigail.gil295@email.com', '052-7413329');
INSERT INTO public.person VALUES (296, 'Yitzchak Friedman', '2014-11-14', 'yitzchak.friedman296@email.com', '050-7092976');
INSERT INTO public.person VALUES (297, 'Isaac Rosen', '2005-10-28', 'isaac.rosen297@email.com', '055-4817576');
INSERT INTO public.person VALUES (298, 'Tamar Rosen', '2006-11-03', 'tamar.rosen298@email.com', '050-5651905');
INSERT INTO public.person VALUES (299, 'Shlomo Shapiro', '2018-03-31', 'shlomo.shapiro299@email.com', '053-1181751');
INSERT INTO public.person VALUES (300, 'Yaakov Gal', '2014-01-02', 'yaakov.gal300@email.com', '055-6048317');
INSERT INTO public.person VALUES (301, 'Michael Carmel', '2016-04-22', 'michael.carmel301@email.com', '058-3820362');
INSERT INTO public.person VALUES (302, 'Avraham Levy', '2012-12-14', 'avraham.levy302@email.com', '055-4021447');
INSERT INTO public.person VALUES (303, 'Shira Chen', '2010-03-10', 'shira.chen303@email.com', '058-5874560');
INSERT INTO public.person VALUES (304, 'Leah Oren', '2014-02-25', 'leah.oren304@email.com', '054-4934287');
INSERT INTO public.person VALUES (305, 'Isaac Rosen', '2009-10-27', 'isaac.rosen305@email.com', '053-6474924');
INSERT INTO public.person VALUES (306, 'Miriam Raz', '2012-05-09', 'miriam.raz306@email.com', '054-9279104');
INSERT INTO public.person VALUES (307, 'Yaakov Zion', '2007-09-07', 'yaakov.zion307@email.com', '058-4819744');
INSERT INTO public.person VALUES (308, 'Yaakov Bar', '2011-06-15', 'yaakov.bar308@email.com', '053-8078778');
INSERT INTO public.person VALUES (309, 'Chana Raz', '2010-05-22', 'chana.raz309@email.com', '050-2915282');
INSERT INTO public.person VALUES (310, 'Tova Ben-Ami', '2010-09-01', 'tova.ben-ami310@email.com', '050-2145424');
INSERT INTO public.person VALUES (311, 'Rebecca Weiss', '2006-12-25', 'rebecca.weiss311@email.com', '058-2297001');
INSERT INTO public.person VALUES (312, 'Joshua Nir', '2016-05-31', 'joshua.nir312@email.com', '058-2932465');
INSERT INTO public.person VALUES (313, 'Hannah Israeli', '2011-04-27', 'hannah.israeli313@email.com', '058-1431641');
INSERT INTO public.person VALUES (314, 'Daniel Carmel', '2016-01-17', 'daniel.carmel314@email.com', '050-9454182');
INSERT INTO public.person VALUES (315, 'Aaron Golan', '2018-06-29', 'aaron.golan315@email.com', '050-1034877');
INSERT INTO public.person VALUES (316, 'Daniel Klein', '2016-05-23', 'daniel.klein316@email.com', '058-8988165');
INSERT INTO public.person VALUES (317, 'Dina Alon', '2016-06-18', 'dina.alon317@email.com', '054-8911638');
INSERT INTO public.person VALUES (318, 'Tova Avraham', '2015-03-10', 'tova.avraham318@email.com', '050-9386523');
INSERT INTO public.person VALUES (319, 'Aaron Tal', '2005-11-09', 'aaron.tal319@email.com', '053-3136883');
INSERT INTO public.person VALUES (320, 'David Klein', '2017-03-20', 'david.klein320@email.com', '052-2769471');
INSERT INTO public.person VALUES (321, 'Adam Gil', '2009-07-17', 'adam.gil321@email.com', '050-8816795');
INSERT INTO public.person VALUES (322, 'David Sharon', '2012-09-17', 'david.sharon322@email.com', '054-6375470');
INSERT INTO public.person VALUES (323, 'Shira Paz', '2011-02-22', 'shira.paz323@email.com', '055-3825491');
INSERT INTO public.person VALUES (324, 'Benjamin Friedman', '2016-09-24', 'benjamin.friedman324@email.com', '053-4409969');
INSERT INTO public.person VALUES (325, 'Benjamin Stern', '2006-04-18', 'benjamin.stern325@email.com', '053-2029559');
INSERT INTO public.person VALUES (326, 'Miriam Israeli', '2009-09-13', 'miriam.israeli326@email.com', '050-7387295');
INSERT INTO public.person VALUES (327, 'Noah Sharon', '2011-09-14', 'noah.sharon327@email.com', '052-7143490');
INSERT INTO public.person VALUES (328, 'Isaac Friedman', '2017-01-15', 'isaac.friedman328@email.com', '058-2001824');
INSERT INTO public.person VALUES (329, 'Yaakov Gal', '2013-12-15', 'yaakov.gal329@email.com', '054-3292983');
INSERT INTO public.person VALUES (330, 'Shira Raz', '2005-03-06', 'shira.raz330@email.com', '055-9212680');
INSERT INTO public.person VALUES (331, 'Daniel Israeli', '2015-05-28', 'daniel.israeli331@email.com', '050-9834086');
INSERT INTO public.person VALUES (332, 'Sara Klein', '2010-06-25', 'sara.klein332@email.com', '055-3143550');
INSERT INTO public.person VALUES (333, 'Avi Stern', '2016-12-31', 'avi.stern333@email.com', '052-4560611');
INSERT INTO public.person VALUES (334, 'Chana Galili', '2018-05-07', 'chana.galili334@email.com', '052-3967478');
INSERT INTO public.person VALUES (335, 'Malka Katz', '2016-01-11', 'malka.katz335@email.com', '050-2252504');
INSERT INTO public.person VALUES (336, 'Joseph Tal', '2017-11-02', 'joseph.tal336@email.com', '050-7506810');
INSERT INTO public.person VALUES (337, 'Moshe Rosen', '2006-10-22', 'moshe.rosen337@email.com', '050-1254337');
INSERT INTO public.person VALUES (338, 'Yaakov Bar', '2010-02-03', 'yaakov.bar338@email.com', '054-3702769');
INSERT INTO public.person VALUES (339, 'Sara Levy', '2005-04-03', 'sara.levy339@email.com', '053-6534832');
INSERT INTO public.person VALUES (340, 'Ruth Katz', '2010-03-11', 'ruth.katz340@email.com', '053-1166353');
INSERT INTO public.person VALUES (341, 'Naomi Klein', '2010-07-05', 'naomi.klein341@email.com', '055-8115972');
INSERT INTO public.person VALUES (342, 'Yosef Mizrahi', '2007-06-05', 'yosef.mizrahi342@email.com', '058-3304928');
INSERT INTO public.person VALUES (343, 'Dina Katz', '2012-11-21', 'dina.katz343@email.com', '054-2839180');
INSERT INTO public.person VALUES (344, 'Adam Levi', '2018-09-28', 'adam.levi344@email.com', '058-5607973');
INSERT INTO public.person VALUES (345, 'Noah Klein', '2011-02-03', 'noah.klein345@email.com', '053-3609230');
INSERT INTO public.person VALUES (346, 'Deborah Mor', '2016-09-28', 'deborah.mor346@email.com', '055-2314579');
INSERT INTO public.person VALUES (347, 'Joseph Avraham', '2010-09-30', 'joseph.avraham347@email.com', '053-4458066');
INSERT INTO public.person VALUES (348, 'Aaron Eitan', '2008-12-09', 'aaron.eitan348@email.com', '054-5943100');
INSERT INTO public.person VALUES (349, 'Ruth Friedman', '2017-05-24', 'ruth.friedman349@email.com', '054-6836896');
INSERT INTO public.person VALUES (350, 'Yosef Carmel', '2010-09-18', 'yosef.carmel350@email.com', '058-9979454');
INSERT INTO public.person VALUES (351, 'Malka Rosen', '2008-01-24', 'malka.rosen351@email.com', '054-6118645');
INSERT INTO public.person VALUES (352, 'Sarah Alon', '2014-02-04', 'sarah.alon352@email.com', '053-4916295');
INSERT INTO public.person VALUES (353, 'Isaac Stern', '2012-08-29', 'isaac.stern353@email.com', '053-8358338');
INSERT INTO public.person VALUES (354, 'Aaron Sharon', '2010-04-27', 'aaron.sharon354@email.com', '053-8371311');
INSERT INTO public.person VALUES (355, 'Adam Mor', '2015-03-10', 'adam.mor355@email.com', '053-5775351');
INSERT INTO public.person VALUES (356, 'Rivka Mor', '2016-03-09', 'rivka.mor356@email.com', '050-4541806');
INSERT INTO public.person VALUES (357, 'Samuel Stern', '2006-05-28', 'samuel.stern357@email.com', '055-8147738');
INSERT INTO public.person VALUES (358, 'Abigail Avraham', '2011-12-09', 'abigail.avraham358@email.com', '052-9657971');
INSERT INTO public.person VALUES (359, 'Joshua Friedman', '2006-03-31', 'joshua.friedman359@email.com', '054-5494268');
INSERT INTO public.person VALUES (360, 'David Alon', '2018-09-03', 'david.alon360@email.com', '054-1051550');
INSERT INTO public.person VALUES (361, 'Joseph Zion', '2018-02-20', 'joseph.zion361@email.com', '050-5474142');
INSERT INTO public.person VALUES (362, 'Jacob Zion', '2018-07-10', 'jacob.zion362@email.com', '053-1761432');
INSERT INTO public.person VALUES (363, 'Yael Levy', '2014-09-09', 'yael.levy363@email.com', '053-9071940');
INSERT INTO public.person VALUES (364, 'Naomi Tal', '2018-08-09', 'naomi.tal364@email.com', '052-3113776');
INSERT INTO public.person VALUES (365, 'Leah Galili', '2016-01-14', 'leah.galili365@email.com', '055-7796832');
INSERT INTO public.person VALUES (366, 'Abigail Levi', '2011-12-30', 'abigail.levi366@email.com', '050-3438736');
INSERT INTO public.person VALUES (367, 'Tamar Avraham', '2014-07-24', 'tamar.avraham367@email.com', '050-5529074');
INSERT INTO public.person VALUES (368, 'Benjamin Israeli', '2017-02-15', 'benjamin.israeli368@email.com', '054-5445032');
INSERT INTO public.person VALUES (369, 'Naomi Golan', '2014-10-31', 'naomi.golan369@email.com', '054-2279622');
INSERT INTO public.person VALUES (370, 'Yitzchak Raz', '2006-11-05', 'yitzchak.raz370@email.com', '058-9185374');
INSERT INTO public.person VALUES (371, 'Shlomo Katz', '2017-01-26', 'shlomo.katz371@email.com', '050-7637205');
INSERT INTO public.person VALUES (372, 'Ruth Peretz', '2007-12-02', 'ruth.peretz372@email.com', '054-8250825');
INSERT INTO public.person VALUES (373, 'David Nir', '2013-01-03', 'david.nir373@email.com', '058-8547354');
INSERT INTO public.person VALUES (374, 'Sarah Israeli', '2012-03-12', 'sarah.israeli374@email.com', '055-2400576');
INSERT INTO public.person VALUES (375, 'Chana Mizrahi', '2012-08-02', 'chana.mizrahi375@email.com', '050-1521396');
INSERT INTO public.person VALUES (376, 'Daniel Galili', '2014-04-21', 'daniel.galili376@email.com', '055-8729260');
INSERT INTO public.person VALUES (377, 'Tova Tal', '2008-01-26', 'tova.tal377@email.com', '055-6666301');
INSERT INTO public.person VALUES (378, 'Joseph Nir', '2010-01-26', 'joseph.nir378@email.com', '052-5824944');
INSERT INTO public.person VALUES (379, 'Samuel Tal', '2010-10-15', 'samuel.tal379@email.com', '054-9445254');
INSERT INTO public.person VALUES (380, 'Jacob Peretz', '2010-09-10', 'jacob.peretz380@email.com', '053-5095564');
INSERT INTO public.person VALUES (381, 'Eli Weiss', '2018-12-21', 'eli.weiss381@email.com', '058-4897369');
INSERT INTO public.person VALUES (382, 'David Paz', '2005-05-19', 'david.paz382@email.com', '052-4513712');
INSERT INTO public.person VALUES (383, 'Aaron Rosen', '2009-10-11', 'aaron.rosen383@email.com', '055-5481009');
INSERT INTO public.person VALUES (384, 'Rivka Galili', '2008-05-22', 'rivka.galili384@email.com', '058-2906626');
INSERT INTO public.person VALUES (385, 'Noah Chen', '2013-03-29', 'noah.chen385@email.com', '052-2897670');
INSERT INTO public.person VALUES (386, 'Moshe Davidov', '2017-12-16', 'moshe.davidov386@email.com', '058-1981186');
INSERT INTO public.person VALUES (387, 'Chana Alon', '2013-12-30', 'chana.alon387@email.com', '053-9716540');
INSERT INTO public.person VALUES (388, 'Rivka Eitan', '2005-06-11', 'rivka.eitan388@email.com', '050-7775920');
INSERT INTO public.person VALUES (389, 'Yitzchak Tal', '2009-06-23', 'yitzchak.tal389@email.com', '054-6371607');
INSERT INTO public.person VALUES (390, 'Esther Paz', '2010-04-29', 'esther.paz390@email.com', '058-7957005');
INSERT INTO public.person VALUES (391, 'Samuel Golan', '2012-01-31', 'samuel.golan391@email.com', '058-1735979');
INSERT INTO public.person VALUES (392, 'Chana Chen', '2006-09-09', 'chana.chen392@email.com', '055-9105012');
INSERT INTO public.person VALUES (393, 'Shira Weiss', '2007-11-11', 'shira.weiss393@email.com', '055-3724976');
INSERT INTO public.person VALUES (394, 'Tamar Nir', '2012-04-22', 'tamar.nir394@email.com', '054-2387430');
INSERT INTO public.person VALUES (395, 'Rivka Gal', '2005-11-24', 'rivka.gal395@email.com', '050-6627081');
INSERT INTO public.person VALUES (396, 'Naomi Tal', '2017-12-12', 'naomi.tal396@email.com', '052-4935305');
INSERT INTO public.person VALUES (397, 'Miriam Paz', '2011-07-06', 'miriam.paz397@email.com', '053-3201051');
INSERT INTO public.person VALUES (398, 'Adam Cohen', '2009-12-08', 'adam.cohen398@email.com', '058-1417103');
INSERT INTO public.person VALUES (399, 'Dina Gal', '2016-12-18', 'dina.gal399@email.com', '050-2768781');
INSERT INTO public.person VALUES (400, 'Tova Avraham', '2012-11-22', 'tova.avraham400@email.com', '052-8850707');


--
-- TOC entry 5083 (class 0 OID 17140)
-- Dependencies: 224
-- Data for Name: sports_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sports_class VALUES (1, 'Boxing 1', 8, 163.74, 70, 185);
INSERT INTO public.sports_class VALUES (2, 'Yoga for Kids 2', 20, 203.01, 40, 148);
INSERT INTO public.sports_class VALUES (3, 'Aerobics 3', 7, 302.11, 43, 129);
INSERT INTO public.sports_class VALUES (4, 'Swimming 4', 8, 205.05, 84, 75);
INSERT INTO public.sports_class VALUES (5, 'Cycling 5', 13, 299.87, 80, 157);
INSERT INTO public.sports_class VALUES (6, 'Swimming 6', 20, 432.76, 49, 149);
INSERT INTO public.sports_class VALUES (7, 'Swimming 7', 16, 471.39, 36, 86);
INSERT INTO public.sports_class VALUES (8, 'Gymnastics 8', 7, 357.17, 44, 31);
INSERT INTO public.sports_class VALUES (9, 'Gymnastics 9', 16, 193.49, 69, 130);
INSERT INTO public.sports_class VALUES (10, 'Martial Arts 10', 19, 499.83, 83, 4);
INSERT INTO public.sports_class VALUES (11, 'Tennis Lessons 11', 16, 455.72, 88, 119);
INSERT INTO public.sports_class VALUES (12, 'Volleyball Skills 12', 20, 347.03, 37, 140);
INSERT INTO public.sports_class VALUES (13, 'Martial Arts 13', 11, 328.05, 55, 42);
INSERT INTO public.sports_class VALUES (14, 'Fitness Training 14', 12, 195.87, 31, 78);
INSERT INTO public.sports_class VALUES (15, 'Aerobics 15', 13, 403.34, 62, 34);
INSERT INTO public.sports_class VALUES (16, 'Boxing 16', 17, 200.90, 51, 10);
INSERT INTO public.sports_class VALUES (17, 'Pilates 17', 10, 394.43, 33, 12);
INSERT INTO public.sports_class VALUES (18, 'Aerobics 18', 15, 470.39, 44, 42);
INSERT INTO public.sports_class VALUES (19, 'Pilates 19', 6, 176.69, 44, 74);
INSERT INTO public.sports_class VALUES (20, 'Martial Arts 20', 6, 446.78, 45, 109);
INSERT INTO public.sports_class VALUES (21, 'Basketball Basics 21', 7, 360.09, 62, 48);
INSERT INTO public.sports_class VALUES (22, 'Cycling 22', 17, 449.10, 31, 34);
INSERT INTO public.sports_class VALUES (23, 'Soccer Training 23', 14, 196.84, 46, 158);
INSERT INTO public.sports_class VALUES (24, 'Tennis Lessons 24', 20, 200.03, 88, 123);
INSERT INTO public.sports_class VALUES (25, 'Yoga for Kids 25', 18, 488.28, 52, 165);
INSERT INTO public.sports_class VALUES (26, 'Tennis Lessons 26', 5, 176.78, 87, 158);
INSERT INTO public.sports_class VALUES (27, 'Swimming 27', 19, 394.54, 78, 126);
INSERT INTO public.sports_class VALUES (28, 'Aerobics 28', 12, 258.68, 79, 106);
INSERT INTO public.sports_class VALUES (29, 'Running Club 29', 13, 223.60, 65, 113);
INSERT INTO public.sports_class VALUES (30, 'Aerobics 30', 20, 202.97, 54, 111);
INSERT INTO public.sports_class VALUES (31, 'Gymnastics 31', 15, 353.23, 40, 117);
INSERT INTO public.sports_class VALUES (32, 'Pilates 32', 18, 366.21, 90, 188);
INSERT INTO public.sports_class VALUES (33, 'Soccer Training 33', 13, 448.44, 60, 144);
INSERT INTO public.sports_class VALUES (34, 'Aerobics 34', 9, 320.09, 42, 195);
INSERT INTO public.sports_class VALUES (35, 'Basketball Basics 35', 8, 394.21, 85, 28);
INSERT INTO public.sports_class VALUES (36, 'Gymnastics 36', 19, 387.14, 51, 196);
INSERT INTO public.sports_class VALUES (37, 'Aerobics 37', 16, 361.21, 81, 40);
INSERT INTO public.sports_class VALUES (38, 'Basketball Basics 38', 14, 403.55, 32, 67);
INSERT INTO public.sports_class VALUES (39, 'Running Club 39', 16, 454.26, 41, 120);
INSERT INTO public.sports_class VALUES (40, 'Boxing 40', 15, 150.20, 83, 4);
INSERT INTO public.sports_class VALUES (41, 'Basketball Basics 41', 8, 386.06, 68, 167);
INSERT INTO public.sports_class VALUES (42, 'Yoga for Kids 42', 17, 370.27, 48, 46);
INSERT INTO public.sports_class VALUES (43, 'Fitness Training 43', 8, 174.84, 43, 97);
INSERT INTO public.sports_class VALUES (44, 'Cycling 44', 15, 238.11, 48, 91);
INSERT INTO public.sports_class VALUES (45, 'Martial Arts 45', 19, 478.84, 67, 140);
INSERT INTO public.sports_class VALUES (46, 'Tennis Lessons 46', 9, 326.17, 38, 17);
INSERT INTO public.sports_class VALUES (47, 'Cycling 47', 10, 291.69, 87, 196);
INSERT INTO public.sports_class VALUES (48, 'Pilates 48', 18, 444.78, 36, 167);
INSERT INTO public.sports_class VALUES (49, 'Martial Arts 49', 20, 312.41, 85, 96);
INSERT INTO public.sports_class VALUES (50, 'Yoga for Kids 50', 16, 471.24, 43, 116);
INSERT INTO public.sports_class VALUES (51, 'Boxing 51', 12, 398.73, 86, 131);
INSERT INTO public.sports_class VALUES (52, 'Boxing 52', 5, 332.66, 46, 83);
INSERT INTO public.sports_class VALUES (53, 'Yoga for Kids 53', 19, 193.23, 30, 164);
INSERT INTO public.sports_class VALUES (54, 'Tennis Lessons 54', 10, 267.30, 49, 147);
INSERT INTO public.sports_class VALUES (55, 'Swimming 55', 17, 242.37, 54, 174);
INSERT INTO public.sports_class VALUES (56, 'Tennis Lessons 56', 18, 496.97, 59, 151);
INSERT INTO public.sports_class VALUES (57, 'Gymnastics 57', 20, 392.20, 69, 101);
INSERT INTO public.sports_class VALUES (58, 'Boxing 58', 12, 273.42, 71, 87);
INSERT INTO public.sports_class VALUES (59, 'Boxing 59', 11, 358.70, 48, 174);
INSERT INTO public.sports_class VALUES (60, 'Soccer Training 60', 16, 469.65, 41, 15);
INSERT INTO public.sports_class VALUES (61, 'Yoga for Kids 61', 11, 434.39, 58, 121);
INSERT INTO public.sports_class VALUES (62, 'Cycling 62', 7, 263.02, 64, 127);
INSERT INTO public.sports_class VALUES (63, 'Dance 63', 9, 172.13, 49, 9);
INSERT INTO public.sports_class VALUES (64, 'Aerobics 64', 19, 163.95, 32, 25);
INSERT INTO public.sports_class VALUES (65, 'Running Club 65', 19, 173.50, 76, 184);
INSERT INTO public.sports_class VALUES (66, 'Cycling 66', 16, 334.78, 75, 85);
INSERT INTO public.sports_class VALUES (67, 'Martial Arts 67', 8, 387.17, 43, 177);
INSERT INTO public.sports_class VALUES (68, 'Running Club 68', 11, 327.74, 35, 181);
INSERT INTO public.sports_class VALUES (69, 'Pilates 69', 20, 219.63, 51, 31);
INSERT INTO public.sports_class VALUES (70, 'Aerobics 70', 7, 355.28, 48, 71);
INSERT INTO public.sports_class VALUES (71, 'Gymnastics 71', 13, 349.34, 88, 134);
INSERT INTO public.sports_class VALUES (72, 'Pilates 72', 7, 268.53, 54, 57);
INSERT INTO public.sports_class VALUES (73, 'Yoga for Kids 73', 6, 434.42, 87, 108);
INSERT INTO public.sports_class VALUES (74, 'Basketball Basics 74', 17, 374.68, 67, 30);
INSERT INTO public.sports_class VALUES (75, 'Volleyball Skills 75', 15, 274.21, 62, 17);
INSERT INTO public.sports_class VALUES (76, 'Martial Arts 76', 15, 375.76, 58, 89);
INSERT INTO public.sports_class VALUES (77, 'Volleyball Skills 77', 6, 441.59, 30, 33);
INSERT INTO public.sports_class VALUES (78, 'Aerobics 78', 19, 160.72, 60, 94);
INSERT INTO public.sports_class VALUES (79, 'Pilates 79', 17, 262.34, 36, 75);
INSERT INTO public.sports_class VALUES (80, 'Soccer Training 80', 9, 329.34, 87, 17);
INSERT INTO public.sports_class VALUES (81, 'Cycling 81', 6, 459.48, 36, 80);
INSERT INTO public.sports_class VALUES (82, 'Yoga for Kids 82', 7, 436.24, 41, 180);
INSERT INTO public.sports_class VALUES (83, 'Running Club 83', 14, 188.12, 58, 152);
INSERT INTO public.sports_class VALUES (84, 'Fitness Training 84', 9, 371.98, 82, 115);
INSERT INTO public.sports_class VALUES (85, 'Martial Arts 85', 14, 358.10, 41, 17);
INSERT INTO public.sports_class VALUES (86, 'Gymnastics 86', 16, 429.01, 90, 138);
INSERT INTO public.sports_class VALUES (87, 'Gymnastics 87', 18, 299.27, 42, 67);
INSERT INTO public.sports_class VALUES (88, 'Yoga for Kids 88', 5, 288.79, 70, 124);
INSERT INTO public.sports_class VALUES (89, 'Swimming 89', 16, 475.13, 65, 156);
INSERT INTO public.sports_class VALUES (90, 'Basketball Basics 90', 9, 461.68, 65, 121);
INSERT INTO public.sports_class VALUES (91, 'Pilates 91', 9, 222.10, 89, 118);
INSERT INTO public.sports_class VALUES (92, 'Fitness Training 92', 6, 218.68, 55, 67);
INSERT INTO public.sports_class VALUES (93, 'Aerobics 93', 19, 415.09, 45, 7);
INSERT INTO public.sports_class VALUES (94, 'Dance 94', 20, 222.42, 32, 50);
INSERT INTO public.sports_class VALUES (95, 'Soccer Training 95', 13, 467.37, 81, 88);
INSERT INTO public.sports_class VALUES (96, 'Yoga for Kids 96', 9, 405.25, 47, 142);
INSERT INTO public.sports_class VALUES (97, 'Basketball Basics 97', 5, 211.90, 49, 84);
INSERT INTO public.sports_class VALUES (98, 'Aerobics 98', 6, 410.78, 34, 16);
INSERT INTO public.sports_class VALUES (99, 'Volleyball Skills 99', 13, 376.59, 71, 80);
INSERT INTO public.sports_class VALUES (100, 'Cycling 100', 8, 405.35, 64, 90);
INSERT INTO public.sports_class VALUES (101, 'Aerobics 101', 19, 341.75, 55, 153);
INSERT INTO public.sports_class VALUES (102, 'Pilates 102', 14, 409.67, 44, 40);
INSERT INTO public.sports_class VALUES (103, 'Martial Arts 103', 14, 360.97, 60, 199);
INSERT INTO public.sports_class VALUES (104, 'Martial Arts 104', 8, 266.33, 76, 21);
INSERT INTO public.sports_class VALUES (105, 'Martial Arts 105', 12, 295.81, 63, 190);
INSERT INTO public.sports_class VALUES (106, 'Soccer Training 106', 18, 476.56, 46, 7);
INSERT INTO public.sports_class VALUES (107, 'Volleyball Skills 107', 19, 309.91, 39, 65);
INSERT INTO public.sports_class VALUES (108, 'Gymnastics 108', 13, 375.31, 66, 62);
INSERT INTO public.sports_class VALUES (109, 'Cycling 109', 15, 395.86, 32, 126);
INSERT INTO public.sports_class VALUES (110, 'Soccer Training 110', 14, 245.56, 33, 79);
INSERT INTO public.sports_class VALUES (111, 'Martial Arts 111', 13, 333.25, 62, 67);
INSERT INTO public.sports_class VALUES (112, 'Tennis Lessons 112', 14, 294.41, 48, 89);
INSERT INTO public.sports_class VALUES (113, 'Gymnastics 113', 14, 188.08, 52, 37);
INSERT INTO public.sports_class VALUES (114, 'Volleyball Skills 114', 14, 277.30, 76, 126);
INSERT INTO public.sports_class VALUES (115, 'Basketball Basics 115', 9, 232.48, 33, 25);
INSERT INTO public.sports_class VALUES (116, 'Boxing 116', 15, 186.10, 80, 44);
INSERT INTO public.sports_class VALUES (117, 'Yoga for Kids 117', 7, 389.03, 89, 109);
INSERT INTO public.sports_class VALUES (118, 'Soccer Training 118', 15, 461.82, 43, 13);
INSERT INTO public.sports_class VALUES (119, 'Aerobics 119', 14, 497.40, 64, 74);
INSERT INTO public.sports_class VALUES (120, 'Basketball Basics 120', 16, 272.46, 88, 71);
INSERT INTO public.sports_class VALUES (121, 'Aerobics 121', 12, 460.10, 67, 94);
INSERT INTO public.sports_class VALUES (122, 'Swimming 122', 20, 167.66, 50, 162);
INSERT INTO public.sports_class VALUES (123, 'Yoga for Kids 123', 7, 399.82, 45, 103);
INSERT INTO public.sports_class VALUES (124, 'Gymnastics 124', 13, 315.13, 72, 86);
INSERT INTO public.sports_class VALUES (125, 'Aerobics 125', 16, 231.15, 49, 194);
INSERT INTO public.sports_class VALUES (126, 'Running Club 126', 19, 355.15, 55, 93);
INSERT INTO public.sports_class VALUES (127, 'Volleyball Skills 127', 13, 242.68, 45, 42);
INSERT INTO public.sports_class VALUES (128, 'Tennis Lessons 128', 11, 304.28, 76, 54);
INSERT INTO public.sports_class VALUES (129, 'Cycling 129', 14, 269.74, 66, 72);
INSERT INTO public.sports_class VALUES (130, 'Cycling 130', 20, 236.07, 60, 156);
INSERT INTO public.sports_class VALUES (131, 'Cycling 131', 19, 314.77, 42, 40);
INSERT INTO public.sports_class VALUES (132, 'Pilates 132', 8, 345.13, 45, 2);
INSERT INTO public.sports_class VALUES (133, 'Basketball Basics 133', 20, 478.43, 31, 189);
INSERT INTO public.sports_class VALUES (134, 'Volleyball Skills 134', 13, 431.11, 71, 149);
INSERT INTO public.sports_class VALUES (135, 'Running Club 135', 6, 421.81, 48, 192);
INSERT INTO public.sports_class VALUES (136, 'Soccer Training 136', 11, 408.15, 30, 22);
INSERT INTO public.sports_class VALUES (137, 'Volleyball Skills 137', 20, 255.01, 40, 57);
INSERT INTO public.sports_class VALUES (138, 'Basketball Basics 138', 9, 247.66, 90, 175);
INSERT INTO public.sports_class VALUES (139, 'Boxing 139', 14, 456.20, 49, 20);
INSERT INTO public.sports_class VALUES (140, 'Soccer Training 140', 8, 268.38, 81, 130);
INSERT INTO public.sports_class VALUES (141, 'Boxing 141', 15, 410.40, 40, 181);
INSERT INTO public.sports_class VALUES (142, 'Basketball Basics 142', 20, 408.93, 49, 33);
INSERT INTO public.sports_class VALUES (143, 'Fitness Training 143', 19, 360.88, 30, 77);
INSERT INTO public.sports_class VALUES (144, 'Basketball Basics 144', 6, 352.32, 66, 130);
INSERT INTO public.sports_class VALUES (145, 'Fitness Training 145', 6, 488.77, 51, 10);
INSERT INTO public.sports_class VALUES (146, 'Pilates 146', 20, 276.34, 44, 39);
INSERT INTO public.sports_class VALUES (147, 'Soccer Training 147', 13, 344.30, 32, 102);
INSERT INTO public.sports_class VALUES (148, 'Fitness Training 148', 13, 276.46, 67, 90);
INSERT INTO public.sports_class VALUES (149, 'Fitness Training 149', 15, 370.92, 42, 156);
INSERT INTO public.sports_class VALUES (150, 'Dance 150', 5, 276.60, 54, 46);
INSERT INTO public.sports_class VALUES (151, 'Tennis Lessons 151', 8, 194.29, 56, 23);
INSERT INTO public.sports_class VALUES (152, 'Gymnastics 152', 13, 420.14, 33, 16);
INSERT INTO public.sports_class VALUES (153, 'Aerobics 153', 16, 398.37, 65, 140);
INSERT INTO public.sports_class VALUES (154, 'Soccer Training 154', 6, 291.16, 78, 110);
INSERT INTO public.sports_class VALUES (155, 'Volleyball Skills 155', 12, 273.34, 52, 12);
INSERT INTO public.sports_class VALUES (156, 'Swimming 156', 17, 248.53, 52, 3);
INSERT INTO public.sports_class VALUES (157, 'Basketball Basics 157', 10, 448.76, 60, 119);
INSERT INTO public.sports_class VALUES (158, 'Soccer Training 158', 11, 159.11, 60, 50);
INSERT INTO public.sports_class VALUES (159, 'Running Club 159', 5, 238.10, 69, 149);
INSERT INTO public.sports_class VALUES (160, 'Dance 160', 17, 394.97, 59, 125);
INSERT INTO public.sports_class VALUES (161, 'Soccer Training 161', 20, 446.79, 87, 19);
INSERT INTO public.sports_class VALUES (162, 'Aerobics 162', 8, 336.40, 46, 181);
INSERT INTO public.sports_class VALUES (163, 'Aerobics 163', 20, 473.28, 50, 155);
INSERT INTO public.sports_class VALUES (164, 'Tennis Lessons 164', 13, 163.71, 86, 18);
INSERT INTO public.sports_class VALUES (165, 'Swimming 165', 18, 356.51, 41, 107);
INSERT INTO public.sports_class VALUES (166, 'Pilates 166', 20, 375.42, 61, 129);
INSERT INTO public.sports_class VALUES (167, 'Tennis Lessons 167', 10, 497.14, 38, 88);
INSERT INTO public.sports_class VALUES (168, 'Basketball Basics 168', 12, 463.20, 40, 178);
INSERT INTO public.sports_class VALUES (169, 'Fitness Training 169', 9, 319.60, 39, 105);
INSERT INTO public.sports_class VALUES (170, 'Aerobics 170', 8, 495.63, 48, 172);
INSERT INTO public.sports_class VALUES (171, 'Running Club 171', 9, 411.18, 57, 8);
INSERT INTO public.sports_class VALUES (172, 'Tennis Lessons 172', 12, 395.97, 35, 110);
INSERT INTO public.sports_class VALUES (173, 'Basketball Basics 173', 6, 250.11, 61, 179);
INSERT INTO public.sports_class VALUES (174, 'Volleyball Skills 174', 19, 368.64, 88, 190);
INSERT INTO public.sports_class VALUES (175, 'Boxing 175', 8, 399.24, 84, 133);
INSERT INTO public.sports_class VALUES (176, 'Boxing 176', 13, 476.63, 47, 57);
INSERT INTO public.sports_class VALUES (177, 'Soccer Training 177', 15, 299.42, 65, 95);
INSERT INTO public.sports_class VALUES (178, 'Running Club 178', 7, 288.60, 82, 129);
INSERT INTO public.sports_class VALUES (179, 'Martial Arts 179', 5, 261.79, 43, 5);
INSERT INTO public.sports_class VALUES (180, 'Dance 180', 14, 414.71, 86, 85);
INSERT INTO public.sports_class VALUES (181, 'Boxing 181', 19, 416.53, 48, 48);
INSERT INTO public.sports_class VALUES (182, 'Swimming 182', 19, 421.36, 39, 103);
INSERT INTO public.sports_class VALUES (183, 'Basketball Basics 183', 9, 446.17, 75, 122);
INSERT INTO public.sports_class VALUES (184, 'Gymnastics 184', 12, 290.32, 44, 116);
INSERT INTO public.sports_class VALUES (185, 'Swimming 185', 7, 189.66, 85, 98);
INSERT INTO public.sports_class VALUES (186, 'Cycling 186', 11, 423.45, 59, 124);
INSERT INTO public.sports_class VALUES (187, 'Soccer Training 187', 19, 236.07, 38, 64);
INSERT INTO public.sports_class VALUES (188, 'Tennis Lessons 188', 19, 204.18, 84, 88);
INSERT INTO public.sports_class VALUES (189, 'Yoga for Kids 189', 20, 269.26, 31, 175);
INSERT INTO public.sports_class VALUES (190, 'Boxing 190', 17, 365.84, 37, 177);
INSERT INTO public.sports_class VALUES (191, 'Volleyball Skills 191', 6, 218.92, 31, 106);
INSERT INTO public.sports_class VALUES (192, 'Aerobics 192', 10, 433.84, 66, 107);
INSERT INTO public.sports_class VALUES (193, 'Dance 193', 11, 155.62, 36, 72);
INSERT INTO public.sports_class VALUES (194, 'Boxing 194', 11, 207.27, 63, 81);
INSERT INTO public.sports_class VALUES (195, 'Running Club 195', 15, 195.18, 87, 137);
INSERT INTO public.sports_class VALUES (196, 'Soccer Training 196', 20, 352.47, 34, 90);
INSERT INTO public.sports_class VALUES (197, 'Martial Arts 197', 10, 278.91, 51, 106);
INSERT INTO public.sports_class VALUES (198, 'Gymnastics 198', 12, 316.99, 60, 194);
INSERT INTO public.sports_class VALUES (199, 'Basketball Basics 199', 18, 208.13, 90, 110);
INSERT INTO public.sports_class VALUES (200, 'Tennis Lessons 200', 13, 328.94, 57, 131);


--
-- TOC entry 5079 (class 0 OID 17104)
-- Dependencies: 220
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.student VALUES (1, 'Bialik 5, Jerusalem');
INSERT INTO public.student VALUES (2, 'Basel 58, Ashdod');
INSERT INTO public.student VALUES (3, 'Ben Gurion 71, Ashdod');
INSERT INTO public.student VALUES (4, 'Rabin 93, Rishon LeZion');
INSERT INTO public.student VALUES (5, 'Herzl 46, Petah Tikva');
INSERT INTO public.student VALUES (6, 'King George 83, Netanya');
INSERT INTO public.student VALUES (7, 'Ahad HaAm 46, Petah Tikva');
INSERT INTO public.student VALUES (8, 'HaNassi 86, Haifa');
INSERT INTO public.student VALUES (9, 'Ben Gurion 35, Beersheba');
INSERT INTO public.student VALUES (10, 'HaNassi 23, Rishon LeZion');
INSERT INTO public.student VALUES (11, 'Rothschild 66, Ramat Gan');
INSERT INTO public.student VALUES (12, 'Allenby 30, Tel Aviv');
INSERT INTO public.student VALUES (13, 'Bialik 25, Jerusalem');
INSERT INTO public.student VALUES (14, 'Rabin 83, Netanya');
INSERT INTO public.student VALUES (15, 'Bialik 22, Tel Aviv');
INSERT INTO public.student VALUES (16, 'Jabotinsky 46, Netanya');
INSERT INTO public.student VALUES (17, 'Weizmann 62, Netanya');
INSERT INTO public.student VALUES (18, 'Ben Gurion 92, Jerusalem');
INSERT INTO public.student VALUES (19, 'Ahad HaAm 5, Netanya');
INSERT INTO public.student VALUES (20, 'Rabin 12, Jerusalem');
INSERT INTO public.student VALUES (21, 'Nordau 99, Ashdod');
INSERT INTO public.student VALUES (22, 'Ben Gurion 30, Holon');
INSERT INTO public.student VALUES (23, 'Ahad HaAm 63, Petah Tikva');
INSERT INTO public.student VALUES (24, 'Begin 5, Beersheba');
INSERT INTO public.student VALUES (25, 'Nordau 8, Netanya');
INSERT INTO public.student VALUES (26, 'Ahad HaAm 61, Netanya');
INSERT INTO public.student VALUES (27, 'Ben Gurion 24, Jerusalem');
INSERT INTO public.student VALUES (28, 'HaNassi 13, Petah Tikva');
INSERT INTO public.student VALUES (29, 'Rothschild 63, Haifa');
INSERT INTO public.student VALUES (30, 'Rothschild 53, Ashdod');
INSERT INTO public.student VALUES (31, 'Weizmann 4, Petah Tikva');
INSERT INTO public.student VALUES (32, 'Ahad HaAm 74, Holon');
INSERT INTO public.student VALUES (33, 'King George 18, Netanya');
INSERT INTO public.student VALUES (34, 'Herzl 15, Petah Tikva');
INSERT INTO public.student VALUES (35, 'Rabin 9, Jerusalem');
INSERT INTO public.student VALUES (36, 'Weizmann 58, Ramat Gan');
INSERT INTO public.student VALUES (37, 'Ben Gurion 65, Netanya');
INSERT INTO public.student VALUES (38, 'Ahad HaAm 81, Rishon LeZion');
INSERT INTO public.student VALUES (39, 'Ahad HaAm 8, Ashdod');
INSERT INTO public.student VALUES (40, 'Allenby 67, Beersheba');
INSERT INTO public.student VALUES (41, 'Ahad HaAm 46, Beersheba');
INSERT INTO public.student VALUES (42, 'HaNassi 2, Ramat Gan');
INSERT INTO public.student VALUES (43, 'King George 41, Beersheba');
INSERT INTO public.student VALUES (44, 'Rothschild 100, Beersheba');
INSERT INTO public.student VALUES (45, 'Jabotinsky 27, Petah Tikva');
INSERT INTO public.student VALUES (46, 'Allenby 63, Netanya');
INSERT INTO public.student VALUES (47, 'Weizmann 45, Beersheba');
INSERT INTO public.student VALUES (48, 'Basel 60, Jerusalem');
INSERT INTO public.student VALUES (49, 'King George 56, Ashdod');
INSERT INTO public.student VALUES (50, 'Nordau 35, Ramat Gan');
INSERT INTO public.student VALUES (51, 'Nordau 38, Petah Tikva');
INSERT INTO public.student VALUES (52, 'Dizengoff 38, Holon');
INSERT INTO public.student VALUES (53, 'Ahad HaAm 22, Holon');
INSERT INTO public.student VALUES (54, 'Bialik 37, Jerusalem');
INSERT INTO public.student VALUES (55, 'Bialik 30, Ashdod');
INSERT INTO public.student VALUES (56, 'Bialik 63, Tel Aviv');
INSERT INTO public.student VALUES (57, 'Rothschild 12, Ashdod');
INSERT INTO public.student VALUES (58, 'Dizengoff 31, Beersheba');
INSERT INTO public.student VALUES (59, 'Basel 24, Beersheba');
INSERT INTO public.student VALUES (60, 'Ahad HaAm 17, Tel Aviv');
INSERT INTO public.student VALUES (61, 'Basel 75, Ashdod');
INSERT INTO public.student VALUES (62, 'Allenby 16, Jerusalem');
INSERT INTO public.student VALUES (63, 'Jabotinsky 58, Petah Tikva');
INSERT INTO public.student VALUES (64, 'Herzl 31, Netanya');
INSERT INTO public.student VALUES (65, 'Rabin 73, Petah Tikva');
INSERT INTO public.student VALUES (66, 'Begin 1, Ashdod');
INSERT INTO public.student VALUES (67, 'Begin 94, Ramat Gan');
INSERT INTO public.student VALUES (68, 'Ben Gurion 46, Ramat Gan');
INSERT INTO public.student VALUES (69, 'King George 38, Rishon LeZion');
INSERT INTO public.student VALUES (70, 'Ahad HaAm 48, Haifa');
INSERT INTO public.student VALUES (71, 'Dizengoff 87, Jerusalem');
INSERT INTO public.student VALUES (72, 'Jabotinsky 19, Ashdod');
INSERT INTO public.student VALUES (73, 'Begin 43, Ashdod');
INSERT INTO public.student VALUES (74, 'Dizengoff 51, Ashdod');
INSERT INTO public.student VALUES (75, 'Herzl 4, Tel Aviv');
INSERT INTO public.student VALUES (76, 'King George 38, Ashdod');
INSERT INTO public.student VALUES (77, 'Allenby 55, Rishon LeZion');
INSERT INTO public.student VALUES (78, 'Bialik 65, Haifa');
INSERT INTO public.student VALUES (79, 'Allenby 28, Holon');
INSERT INTO public.student VALUES (80, 'Nordau 22, Beersheba');
INSERT INTO public.student VALUES (81, 'Jabotinsky 97, Haifa');
INSERT INTO public.student VALUES (82, 'King George 33, Haifa');
INSERT INTO public.student VALUES (83, 'Nordau 13, Ramat Gan');
INSERT INTO public.student VALUES (84, 'Nordau 25, Haifa');
INSERT INTO public.student VALUES (85, 'Begin 93, Jerusalem');
INSERT INTO public.student VALUES (86, 'Ahad HaAm 12, Holon');
INSERT INTO public.student VALUES (87, 'King George 100, Ashdod');
INSERT INTO public.student VALUES (88, 'Dizengoff 65, Ramat Gan');
INSERT INTO public.student VALUES (89, 'Allenby 29, Tel Aviv');
INSERT INTO public.student VALUES (90, 'Weizmann 87, Rishon LeZion');
INSERT INTO public.student VALUES (91, 'Basel 15, Ramat Gan');
INSERT INTO public.student VALUES (92, 'Weizmann 28, Jerusalem');
INSERT INTO public.student VALUES (93, 'Jabotinsky 92, Netanya');
INSERT INTO public.student VALUES (94, 'Basel 41, Petah Tikva');
INSERT INTO public.student VALUES (95, 'Rabin 90, Petah Tikva');
INSERT INTO public.student VALUES (96, 'King George 13, Tel Aviv');
INSERT INTO public.student VALUES (97, 'Weizmann 69, Rishon LeZion');
INSERT INTO public.student VALUES (98, 'Allenby 25, Haifa');
INSERT INTO public.student VALUES (99, 'Rabin 47, Tel Aviv');
INSERT INTO public.student VALUES (100, 'Basel 57, Haifa');
INSERT INTO public.student VALUES (101, 'Dizengoff 71, Tel Aviv');
INSERT INTO public.student VALUES (102, 'Dizengoff 26, Tel Aviv');
INSERT INTO public.student VALUES (103, 'Bialik 58, Netanya');
INSERT INTO public.student VALUES (104, 'Bialik 32, Tel Aviv');
INSERT INTO public.student VALUES (105, 'Dizengoff 52, Petah Tikva');
INSERT INTO public.student VALUES (106, 'Jabotinsky 68, Tel Aviv');
INSERT INTO public.student VALUES (107, 'Ben Gurion 78, Beersheba');
INSERT INTO public.student VALUES (108, 'Begin 25, Rishon LeZion');
INSERT INTO public.student VALUES (109, 'Begin 91, Petah Tikva');
INSERT INTO public.student VALUES (110, 'Jabotinsky 70, Ramat Gan');
INSERT INTO public.student VALUES (111, 'Ahad HaAm 99, Holon');
INSERT INTO public.student VALUES (112, 'Weizmann 100, Holon');
INSERT INTO public.student VALUES (113, 'Jabotinsky 5, Tel Aviv');
INSERT INTO public.student VALUES (114, 'Rothschild 53, Holon');
INSERT INTO public.student VALUES (115, 'Ben Gurion 45, Beersheba');
INSERT INTO public.student VALUES (116, 'Rabin 48, Ramat Gan');
INSERT INTO public.student VALUES (117, 'Allenby 17, Haifa');
INSERT INTO public.student VALUES (118, 'Weizmann 32, Holon');
INSERT INTO public.student VALUES (119, 'Begin 99, Haifa');
INSERT INTO public.student VALUES (120, 'Rothschild 97, Tel Aviv');
INSERT INTO public.student VALUES (121, 'Herzl 38, Rishon LeZion');
INSERT INTO public.student VALUES (122, 'Jabotinsky 64, Netanya');
INSERT INTO public.student VALUES (123, 'Herzl 21, Ashdod');
INSERT INTO public.student VALUES (124, 'Basel 9, Haifa');
INSERT INTO public.student VALUES (125, 'Rothschild 49, Haifa');
INSERT INTO public.student VALUES (126, 'Ben Gurion 66, Ashdod');
INSERT INTO public.student VALUES (127, 'Allenby 49, Tel Aviv');
INSERT INTO public.student VALUES (128, 'Rothschild 85, Jerusalem');
INSERT INTO public.student VALUES (129, 'Herzl 43, Rishon LeZion');
INSERT INTO public.student VALUES (130, 'HaNassi 15, Holon');
INSERT INTO public.student VALUES (131, 'Bialik 2, Netanya');
INSERT INTO public.student VALUES (132, 'Weizmann 90, Beersheba');
INSERT INTO public.student VALUES (133, 'Nordau 94, Jerusalem');
INSERT INTO public.student VALUES (134, 'HaNassi 52, Ashdod');
INSERT INTO public.student VALUES (135, 'Rabin 6, Ramat Gan');
INSERT INTO public.student VALUES (136, 'Weizmann 11, Petah Tikva');
INSERT INTO public.student VALUES (137, 'Rabin 20, Haifa');
INSERT INTO public.student VALUES (138, 'Ben Gurion 45, Ramat Gan');
INSERT INTO public.student VALUES (139, 'Rothschild 11, Holon');
INSERT INTO public.student VALUES (140, 'Rabin 11, Tel Aviv');
INSERT INTO public.student VALUES (141, 'King George 63, Haifa');
INSERT INTO public.student VALUES (142, 'Herzl 26, Tel Aviv');
INSERT INTO public.student VALUES (143, 'Nordau 7, Beersheba');
INSERT INTO public.student VALUES (144, 'Rothschild 66, Beersheba');
INSERT INTO public.student VALUES (145, 'Begin 17, Holon');
INSERT INTO public.student VALUES (146, 'Ahad HaAm 81, Ashdod');
INSERT INTO public.student VALUES (147, 'Herzl 84, Jerusalem');
INSERT INTO public.student VALUES (148, 'HaNassi 73, Ashdod');
INSERT INTO public.student VALUES (149, 'Allenby 58, Holon');
INSERT INTO public.student VALUES (150, 'Basel 7, Holon');
INSERT INTO public.student VALUES (201, 'Allenby 8, Petah Tikva');
INSERT INTO public.student VALUES (202, 'HaNassi 34, Rishon LeZion');
INSERT INTO public.student VALUES (203, 'Weizmann 135, Kfar Saba');
INSERT INTO public.student VALUES (204, 'HaNassi 111, Ashdod');
INSERT INTO public.student VALUES (205, 'Basel 59, Petah Tikva');
INSERT INTO public.student VALUES (206, 'Jabotinsky 58, Rehovot');
INSERT INTO public.student VALUES (207, 'Dizengoff 145, Rishon LeZion');
INSERT INTO public.student VALUES (208, 'HaNassi 95, Tel Aviv');
INSERT INTO public.student VALUES (209, 'Ibn Gabirol 4, Kfar Saba');
INSERT INTO public.student VALUES (210, 'Ibn Gabirol 36, Holon');
INSERT INTO public.student VALUES (211, 'Frishman 20, Rehovot');
INSERT INTO public.student VALUES (212, 'Sokolov 10, Rehovot');
INSERT INTO public.student VALUES (213, 'HaNassi 15, Ashdod');
INSERT INTO public.student VALUES (214, 'Rabin 6, Holon');
INSERT INTO public.student VALUES (215, 'Ben Gurion 113, Petah Tikva');
INSERT INTO public.student VALUES (216, 'Begin 52, Rehovot');
INSERT INTO public.student VALUES (217, 'Dizengoff 30, Ashdod');
INSERT INTO public.student VALUES (218, 'Basel 124, Rehovot');
INSERT INTO public.student VALUES (219, 'Bialik 148, Rishon LeZion');
INSERT INTO public.student VALUES (220, 'Jabotinsky 5, Jerusalem');
INSERT INTO public.student VALUES (221, 'Allenby 11, Rehovot');
INSERT INTO public.student VALUES (222, 'HaNassi 125, Bat Yam');
INSERT INTO public.student VALUES (223, 'Herzl 148, Beersheba');
INSERT INTO public.student VALUES (224, 'Sheinkin 138, Netanya');
INSERT INTO public.student VALUES (225, 'Herzl 143, Rehovot');
INSERT INTO public.student VALUES (226, 'Rabin 3, Jerusalem');
INSERT INTO public.student VALUES (227, 'Rabin 40, Ashdod');
INSERT INTO public.student VALUES (228, 'Rabin 91, Rehovot');
INSERT INTO public.student VALUES (229, 'Ibn Gabirol 41, Netanya');
INSERT INTO public.student VALUES (230, 'Ibn Gabirol 56, Jerusalem');
INSERT INTO public.student VALUES (231, 'Dizengoff 44, Netanya');
INSERT INTO public.student VALUES (232, 'Herzl 39, Beersheba');
INSERT INTO public.student VALUES (233, 'Ibn Gabirol 77, Ashdod');
INSERT INTO public.student VALUES (234, 'Ahad HaAm 35, Ramat Gan');
INSERT INTO public.student VALUES (235, 'Weizmann 94, Rishon LeZion');
INSERT INTO public.student VALUES (236, 'Herzl 65, Petah Tikva');
INSERT INTO public.student VALUES (237, 'Sokolov 111, Tel Aviv');
INSERT INTO public.student VALUES (238, 'Dizengoff 37, Bat Yam');
INSERT INTO public.student VALUES (239, 'Sheinkin 140, Haifa');
INSERT INTO public.student VALUES (240, 'Bialik 52, Ashdod');
INSERT INTO public.student VALUES (241, 'Weizmann 61, Jerusalem');
INSERT INTO public.student VALUES (242, 'Begin 90, Haifa');
INSERT INTO public.student VALUES (243, 'Rabin 98, Kfar Saba');
INSERT INTO public.student VALUES (244, 'Rabin 108, Netanya');
INSERT INTO public.student VALUES (245, 'Allenby 145, Ashdod');
INSERT INTO public.student VALUES (246, 'Sheinkin 52, Haifa');
INSERT INTO public.student VALUES (247, 'Begin 117, Kfar Saba');
INSERT INTO public.student VALUES (248, 'Ahad HaAm 99, Bat Yam');
INSERT INTO public.student VALUES (249, 'King George 91, Ashdod');
INSERT INTO public.student VALUES (250, 'Gordon 45, Petah Tikva');
INSERT INTO public.student VALUES (251, 'Ibn Gabirol 87, Holon');
INSERT INTO public.student VALUES (252, 'Allenby 82, Netanya');
INSERT INTO public.student VALUES (253, 'King George 81, Holon');
INSERT INTO public.student VALUES (254, 'Gordon 121, Netanya');
INSERT INTO public.student VALUES (255, 'Jabotinsky 60, Jerusalem');
INSERT INTO public.student VALUES (256, 'Rabin 25, Bat Yam');
INSERT INTO public.student VALUES (257, 'King George 147, Jerusalem');
INSERT INTO public.student VALUES (258, 'Basel 122, Haifa');
INSERT INTO public.student VALUES (259, 'Rabin 7, Rishon LeZion');
INSERT INTO public.student VALUES (260, 'Sheinkin 143, Petah Tikva');
INSERT INTO public.student VALUES (261, 'King George 64, Holon');
INSERT INTO public.student VALUES (262, 'King George 19, Petah Tikva');
INSERT INTO public.student VALUES (263, 'Jabotinsky 108, Beersheba');
INSERT INTO public.student VALUES (264, 'Basel 25, Kfar Saba');
INSERT INTO public.student VALUES (265, 'Gordon 150, Petah Tikva');
INSERT INTO public.student VALUES (266, 'Sheinkin 44, Rehovot');
INSERT INTO public.student VALUES (267, 'Begin 108, Tel Aviv');
INSERT INTO public.student VALUES (268, 'Allenby 119, Beersheba');
INSERT INTO public.student VALUES (269, 'Ibn Gabirol 119, Ashdod');
INSERT INTO public.student VALUES (270, 'Rabin 3, Netanya');
INSERT INTO public.student VALUES (271, 'Weizmann 86, Ramat Gan');
INSERT INTO public.student VALUES (272, 'Begin 86, Beersheba');
INSERT INTO public.student VALUES (273, 'Sokolov 108, Holon');
INSERT INTO public.student VALUES (274, 'Nordau 117, Netanya');
INSERT INTO public.student VALUES (275, 'Dizengoff 55, Ashdod');
INSERT INTO public.student VALUES (276, 'Rothschild 98, Petah Tikva');
INSERT INTO public.student VALUES (277, 'Gordon 103, Rehovot');
INSERT INTO public.student VALUES (278, 'HaNassi 124, Rehovot');
INSERT INTO public.student VALUES (279, 'Weizmann 27, Haifa');
INSERT INTO public.student VALUES (280, 'Basel 1, Haifa');
INSERT INTO public.student VALUES (281, 'Ibn Gabirol 28, Rehovot');
INSERT INTO public.student VALUES (282, 'Begin 74, Kfar Saba');
INSERT INTO public.student VALUES (283, 'Jabotinsky 44, Petah Tikva');
INSERT INTO public.student VALUES (284, 'Allenby 46, Tel Aviv');
INSERT INTO public.student VALUES (285, 'Begin 141, Haifa');
INSERT INTO public.student VALUES (286, 'HaNassi 2, Kfar Saba');
INSERT INTO public.student VALUES (287, 'Ben Gurion 30, Ashdod');
INSERT INTO public.student VALUES (288, 'Rabin 14, Netanya');
INSERT INTO public.student VALUES (289, 'Rothschild 30, Netanya');
INSERT INTO public.student VALUES (290, 'Nordau 78, Jerusalem');
INSERT INTO public.student VALUES (291, 'Rothschild 1, Bat Yam');
INSERT INTO public.student VALUES (292, 'Ibn Gabirol 83, Jerusalem');
INSERT INTO public.student VALUES (293, 'Sokolov 32, Haifa');
INSERT INTO public.student VALUES (294, 'Sokolov 48, Ashdod');
INSERT INTO public.student VALUES (295, 'Dizengoff 143, Jerusalem');
INSERT INTO public.student VALUES (296, 'Rabin 1, Rishon LeZion');
INSERT INTO public.student VALUES (297, 'King George 48, Bat Yam');
INSERT INTO public.student VALUES (298, 'Frishman 55, Ashdod');
INSERT INTO public.student VALUES (299, 'Basel 16, Tel Aviv');
INSERT INTO public.student VALUES (300, 'Basel 63, Haifa');
INSERT INTO public.student VALUES (301, 'Rabin 97, Tel Aviv');
INSERT INTO public.student VALUES (302, 'Sokolov 69, Haifa');
INSERT INTO public.student VALUES (303, 'Begin 119, Rehovot');
INSERT INTO public.student VALUES (304, 'Ahad HaAm 133, Beersheba');
INSERT INTO public.student VALUES (305, 'HaNassi 31, Holon');
INSERT INTO public.student VALUES (306, 'Bialik 81, Kfar Saba');
INSERT INTO public.student VALUES (307, 'Sokolov 9, Petah Tikva');
INSERT INTO public.student VALUES (308, 'Nordau 119, Haifa');
INSERT INTO public.student VALUES (309, 'HaNassi 144, Kfar Saba');
INSERT INTO public.student VALUES (310, 'Sheinkin 100, Holon');
INSERT INTO public.student VALUES (311, 'Ahad HaAm 92, Haifa');
INSERT INTO public.student VALUES (312, 'Frishman 79, Jerusalem');
INSERT INTO public.student VALUES (313, 'Sokolov 34, Ashdod');
INSERT INTO public.student VALUES (314, 'King George 2, Tel Aviv');
INSERT INTO public.student VALUES (315, 'Dizengoff 110, Netanya');
INSERT INTO public.student VALUES (316, 'Rothschild 101, Holon');
INSERT INTO public.student VALUES (317, 'Ibn Gabirol 25, Beersheba');
INSERT INTO public.student VALUES (318, 'Allenby 41, Haifa');
INSERT INTO public.student VALUES (319, 'Gordon 149, Rishon LeZion');
INSERT INTO public.student VALUES (320, 'Rothschild 55, Ashdod');
INSERT INTO public.student VALUES (321, 'HaNassi 98, Holon');
INSERT INTO public.student VALUES (322, 'Bialik 126, Beersheba');
INSERT INTO public.student VALUES (323, 'Dizengoff 11, Ashdod');
INSERT INTO public.student VALUES (324, 'Ibn Gabirol 100, Ramat Gan');
INSERT INTO public.student VALUES (325, 'Gordon 114, Haifa');
INSERT INTO public.student VALUES (326, 'Ahad HaAm 141, Haifa');
INSERT INTO public.student VALUES (327, 'Herzl 42, Tel Aviv');
INSERT INTO public.student VALUES (328, 'Ahad HaAm 143, Netanya');
INSERT INTO public.student VALUES (329, 'Gordon 85, Kfar Saba');
INSERT INTO public.student VALUES (330, 'Frishman 140, Ramat Gan');
INSERT INTO public.student VALUES (331, 'Allenby 16, Bat Yam');
INSERT INTO public.student VALUES (332, 'Rothschild 115, Rehovot');
INSERT INTO public.student VALUES (333, 'Allenby 69, Netanya');
INSERT INTO public.student VALUES (334, 'Begin 120, Bat Yam');
INSERT INTO public.student VALUES (335, 'Bialik 7, Kfar Saba');
INSERT INTO public.student VALUES (336, 'Bialik 74, Kfar Saba');
INSERT INTO public.student VALUES (337, 'Gordon 101, Holon');
INSERT INTO public.student VALUES (338, 'Nordau 56, Ramat Gan');
INSERT INTO public.student VALUES (339, 'Ben Gurion 31, Rehovot');
INSERT INTO public.student VALUES (340, 'Rothschild 71, Netanya');
INSERT INTO public.student VALUES (341, 'Rabin 140, Ashdod');
INSERT INTO public.student VALUES (342, 'Ibn Gabirol 150, Rehovot');
INSERT INTO public.student VALUES (343, 'Nordau 107, Haifa');
INSERT INTO public.student VALUES (344, 'Ben Gurion 92, Petah Tikva');
INSERT INTO public.student VALUES (345, 'Sheinkin 104, Beersheba');
INSERT INTO public.student VALUES (346, 'Frishman 131, Petah Tikva');
INSERT INTO public.student VALUES (347, 'Ibn Gabirol 39, Holon');
INSERT INTO public.student VALUES (348, 'Rabin 73, Beersheba');
INSERT INTO public.student VALUES (349, 'Ibn Gabirol 71, Holon');
INSERT INTO public.student VALUES (350, 'Herzl 146, Rehovot');
INSERT INTO public.student VALUES (351, 'Dizengoff 62, Holon');
INSERT INTO public.student VALUES (352, 'Weizmann 13, Bat Yam');
INSERT INTO public.student VALUES (353, 'Bialik 90, Netanya');
INSERT INTO public.student VALUES (354, 'Herzl 11, Haifa');
INSERT INTO public.student VALUES (355, 'Allenby 110, Kfar Saba');
INSERT INTO public.student VALUES (356, 'Allenby 35, Tel Aviv');
INSERT INTO public.student VALUES (357, 'Gordon 81, Petah Tikva');
INSERT INTO public.student VALUES (358, 'Basel 136, Bat Yam');
INSERT INTO public.student VALUES (359, 'HaNassi 54, Rishon LeZion');
INSERT INTO public.student VALUES (360, 'HaNassi 93, Jerusalem');
INSERT INTO public.student VALUES (361, 'Dizengoff 57, Tel Aviv');
INSERT INTO public.student VALUES (362, 'Ben Gurion 57, Ramat Gan');
INSERT INTO public.student VALUES (363, 'Nordau 49, Bat Yam');
INSERT INTO public.student VALUES (364, 'King George 12, Netanya');
INSERT INTO public.student VALUES (365, 'Ahad HaAm 33, Haifa');
INSERT INTO public.student VALUES (366, 'Rabin 123, Haifa');
INSERT INTO public.student VALUES (367, 'Weizmann 102, Petah Tikva');
INSERT INTO public.student VALUES (368, 'Begin 19, Jerusalem');
INSERT INTO public.student VALUES (369, 'Jabotinsky 40, Haifa');
INSERT INTO public.student VALUES (370, 'Sheinkin 54, Jerusalem');
INSERT INTO public.student VALUES (371, 'Begin 44, Ashdod');
INSERT INTO public.student VALUES (372, 'Basel 112, Ashdod');
INSERT INTO public.student VALUES (373, 'Sheinkin 47, Holon');
INSERT INTO public.student VALUES (374, 'Allenby 56, Ashdod');
INSERT INTO public.student VALUES (375, 'Basel 33, Ashdod');
INSERT INTO public.student VALUES (376, 'Begin 114, Haifa');
INSERT INTO public.student VALUES (377, 'Sokolov 56, Holon');
INSERT INTO public.student VALUES (378, 'Dizengoff 39, Haifa');
INSERT INTO public.student VALUES (379, 'Basel 73, Petah Tikva');
INSERT INTO public.student VALUES (380, 'Sheinkin 62, Kfar Saba');
INSERT INTO public.student VALUES (381, 'Sheinkin 144, Jerusalem');
INSERT INTO public.student VALUES (382, 'Allenby 105, Ashdod');
INSERT INTO public.student VALUES (383, 'HaNassi 92, Netanya');
INSERT INTO public.student VALUES (384, 'Frishman 65, Tel Aviv');
INSERT INTO public.student VALUES (385, 'King George 133, Petah Tikva');
INSERT INTO public.student VALUES (386, 'Sokolov 84, Haifa');
INSERT INTO public.student VALUES (387, 'Ahad HaAm 32, Rishon LeZion');
INSERT INTO public.student VALUES (388, 'Bialik 88, Netanya');
INSERT INTO public.student VALUES (389, 'Sheinkin 137, Rehovot');
INSERT INTO public.student VALUES (390, 'Jabotinsky 83, Jerusalem');
INSERT INTO public.student VALUES (391, 'Begin 100, Bat Yam');
INSERT INTO public.student VALUES (392, 'Ahad HaAm 58, Ramat Gan');
INSERT INTO public.student VALUES (393, 'Frishman 18, Kfar Saba');
INSERT INTO public.student VALUES (394, 'Nordau 37, Haifa');
INSERT INTO public.student VALUES (395, 'Frishman 72, Holon');
INSERT INTO public.student VALUES (396, 'King George 88, Holon');
INSERT INTO public.student VALUES (397, 'Allenby 129, Ashdod');
INSERT INTO public.student VALUES (398, 'Rabin 74, Bat Yam');
INSERT INTO public.student VALUES (399, 'Weizmann 38, Rehovot');
INSERT INTO public.student VALUES (400, 'Rothschild 108, Beersheba');


--
-- TOC entry 5080 (class 0 OID 17115)
-- Dependencies: 221
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.teacher VALUES (151, 10650.14, '2023-08-06');
INSERT INTO public.teacher VALUES (152, 18871.52, '2015-12-21');
INSERT INTO public.teacher VALUES (153, 13994.01, '2018-10-29');
INSERT INTO public.teacher VALUES (154, 17870.44, '2022-09-11');
INSERT INTO public.teacher VALUES (155, 15184.38, '2018-04-19');
INSERT INTO public.teacher VALUES (156, 18728.43, '2020-07-23');
INSERT INTO public.teacher VALUES (157, 18751.00, '2023-07-19');
INSERT INTO public.teacher VALUES (158, 19963.50, '2017-09-15');
INSERT INTO public.teacher VALUES (159, 13191.10, '2016-04-30');
INSERT INTO public.teacher VALUES (160, 16495.05, '2021-04-12');
INSERT INTO public.teacher VALUES (161, 19893.67, '2020-05-21');
INSERT INTO public.teacher VALUES (162, 19147.73, '2016-07-07');
INSERT INTO public.teacher VALUES (163, 14232.54, '2018-10-30');
INSERT INTO public.teacher VALUES (164, 16489.30, '2015-12-26');
INSERT INTO public.teacher VALUES (165, 16583.91, '2019-09-05');
INSERT INTO public.teacher VALUES (166, 12869.28, '2017-04-04');
INSERT INTO public.teacher VALUES (167, 19703.00, '2017-04-02');
INSERT INTO public.teacher VALUES (168, 16060.73, '2021-10-20');
INSERT INTO public.teacher VALUES (169, 13419.62, '2016-04-30');
INSERT INTO public.teacher VALUES (170, 14770.53, '2019-08-30');
INSERT INTO public.teacher VALUES (171, 11130.88, '2022-12-05');
INSERT INTO public.teacher VALUES (172, 18462.35, '2017-07-11');
INSERT INTO public.teacher VALUES (173, 10554.90, '2022-09-05');
INSERT INTO public.teacher VALUES (174, 13711.52, '2020-07-14');
INSERT INTO public.teacher VALUES (175, 16233.91, '2023-06-06');
INSERT INTO public.teacher VALUES (176, 10715.90, '2016-11-03');
INSERT INTO public.teacher VALUES (177, 11497.77, '2021-07-13');
INSERT INTO public.teacher VALUES (178, 17614.11, '2017-11-05');
INSERT INTO public.teacher VALUES (179, 19955.13, '2024-02-24');
INSERT INTO public.teacher VALUES (180, 17579.79, '2019-03-05');
INSERT INTO public.teacher VALUES (181, 15995.65, '2023-09-07');
INSERT INTO public.teacher VALUES (182, 16648.84, '2023-09-16');
INSERT INTO public.teacher VALUES (183, 16202.01, '2017-04-17');
INSERT INTO public.teacher VALUES (184, 19510.09, '2015-03-29');
INSERT INTO public.teacher VALUES (185, 11386.54, '2023-02-05');
INSERT INTO public.teacher VALUES (186, 18503.77, '2018-09-11');
INSERT INTO public.teacher VALUES (187, 15220.20, '2018-05-19');
INSERT INTO public.teacher VALUES (188, 18837.04, '2021-07-23');
INSERT INTO public.teacher VALUES (189, 17417.14, '2020-11-03');
INSERT INTO public.teacher VALUES (190, 14618.44, '2020-05-28');
INSERT INTO public.teacher VALUES (191, 15668.84, '2016-08-01');
INSERT INTO public.teacher VALUES (192, 11843.91, '2023-06-05');
INSERT INTO public.teacher VALUES (193, 15332.96, '2017-11-02');
INSERT INTO public.teacher VALUES (194, 13509.53, '2021-06-08');
INSERT INTO public.teacher VALUES (195, 18189.80, '2023-06-06');
INSERT INTO public.teacher VALUES (196, 14549.38, '2020-07-04');
INSERT INTO public.teacher VALUES (197, 12108.10, '2024-07-28');
INSERT INTO public.teacher VALUES (198, 13835.85, '2016-05-19');
INSERT INTO public.teacher VALUES (199, 11031.33, '2024-10-17');
INSERT INTO public.teacher VALUES (200, 19661.13, '2017-07-31');


--
-- TOC entry 4904 (class 2606 OID 17139)
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- TOC entry 4909 (class 2606 OID 17164)
-- Name: group_of_sports group_of_sports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_of_sports
    ADD CONSTRAINT group_of_sports_pkey PRIMARY KEY (id);


--
-- TOC entry 4902 (class 2606 OID 17132)
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- TOC entry 4919 (class 2606 OID 17198)
-- Name: needs needs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.needs
    ADD CONSTRAINT needs_pkey PRIMARY KEY (equipment_id, sports_class_id);


--
-- TOC entry 4915 (class 2606 OID 17181)
-- Name: participate_in participate_in_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participate_in
    ADD CONSTRAINT participate_in_pkey PRIMARY KEY (student_id, group_id);


--
-- TOC entry 4894 (class 2606 OID 17103)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 4907 (class 2606 OID 17149)
-- Name: sports_class sports_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_class
    ADD CONSTRAINT sports_class_pkey PRIMARY KEY (id);


--
-- TOC entry 4897 (class 2606 OID 17109)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 17120)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- TOC entry 4910 (class 1259 OID 17217)
-- Name: idx_group_sports_class; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_sports_class ON public.group_of_sports USING btree (sports_class_id);


--
-- TOC entry 4911 (class 1259 OID 17216)
-- Name: idx_group_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_teacher ON public.group_of_sports USING btree (teacher_id);


--
-- TOC entry 4916 (class 1259 OID 17220)
-- Name: idx_needs_equipment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_needs_equipment ON public.needs USING btree (equipment_id);


--
-- TOC entry 4917 (class 1259 OID 17221)
-- Name: idx_needs_sports_class; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_needs_sports_class ON public.needs USING btree (sports_class_id);


--
-- TOC entry 4912 (class 1259 OID 17219)
-- Name: idx_participate_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_participate_group ON public.participate_in USING btree (group_id);


--
-- TOC entry 4913 (class 1259 OID 17218)
-- Name: idx_participate_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_participate_student ON public.participate_in USING btree (student_id);


--
-- TOC entry 4905 (class 1259 OID 17215)
-- Name: idx_sports_class_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sports_class_location ON public.sports_class USING btree (location_id);


--
-- TOC entry 4895 (class 1259 OID 17213)
-- Name: idx_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_student_id ON public.student USING btree (id);


--
-- TOC entry 4898 (class 1259 OID 17214)
-- Name: idx_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_teacher_id ON public.teacher USING btree (id);


--
-- TOC entry 4929 (class 2620 OID 17212)
-- Name: participate_in trg_delete_participate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_delete_participate AFTER DELETE ON public.participate_in FOR EACH ROW EXECUTE FUNCTION public.update_current_amount_on_delete();


--
-- TOC entry 4930 (class 2620 OID 17211)
-- Name: participate_in trg_insert_participate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_insert_participate AFTER INSERT ON public.participate_in FOR EACH ROW EXECUTE FUNCTION public.update_current_amount_on_insert();


--
-- TOC entry 4923 (class 2606 OID 17170)
-- Name: group_of_sports group_of_sports_sports_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_of_sports
    ADD CONSTRAINT group_of_sports_sports_class_id_fkey FOREIGN KEY (sports_class_id) REFERENCES public.sports_class(id) ON DELETE CASCADE;


--
-- TOC entry 4924 (class 2606 OID 17165)
-- Name: group_of_sports group_of_sports_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_of_sports
    ADD CONSTRAINT group_of_sports_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(id);


--
-- TOC entry 4927 (class 2606 OID 17199)
-- Name: needs needs_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.needs
    ADD CONSTRAINT needs_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(id);


--
-- TOC entry 4928 (class 2606 OID 17204)
-- Name: needs needs_sports_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.needs
    ADD CONSTRAINT needs_sports_class_id_fkey FOREIGN KEY (sports_class_id) REFERENCES public.sports_class(id) ON DELETE CASCADE;


--
-- TOC entry 4925 (class 2606 OID 17187)
-- Name: participate_in participate_in_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participate_in
    ADD CONSTRAINT participate_in_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.group_of_sports(id) ON DELETE CASCADE;


--
-- TOC entry 4926 (class 2606 OID 17182)
-- Name: participate_in participate_in_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participate_in
    ADD CONSTRAINT participate_in_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 4922 (class 2606 OID 17150)
-- Name: sports_class sports_class_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sports_class
    ADD CONSTRAINT sports_class_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id);


--
-- TOC entry 4920 (class 2606 OID 17110)
-- Name: student student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_id_fkey FOREIGN KEY (id) REFERENCES public.person(id) ON DELETE CASCADE;


--
-- TOC entry 4921 (class 2606 OID 17121)
-- Name: teacher teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_id_fkey FOREIGN KEY (id) REFERENCES public.person(id) ON DELETE CASCADE;


-- Completed on 2025-11-11 20:31:40

--
-- PostgreSQL database dump complete
--

\unrestrict ewOQRInkricLeiyy7LqIUonJLUni2QMDlyl9kSxwkPcorsnW0xXeGUTAmQf4dzC

