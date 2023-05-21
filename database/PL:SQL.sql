-- SET SERVEROUTPUT ON 
DECLARE
	x_dept_name varchar(20); 
	x_id VARCHAR(5); 
	x_name VARCHAR(20); 
	x_course_id varchar(8); 
	x_semester varchar(8); 
	x_year numeric(4,0); 
	x_grade VARCHAR(5); 
	x_credits int;
	x_title VARCHAR(40); 
	x_tot_credit int; 
	x_gpa numeric(4,1); 
	x_point numeric(2,1);

	CURSOR c1 is
		SELECT dept_name 
		FROM department 
		ORDER BY dept_name;
	CURSOR c2 is
		SELECT id, name
		FROM student
		WHERE dept_name = x_dept_name 
		ORDER BY name;
	CURSOR c3 is
		SELECT title, credits, semester, year, grade
		FROM takes left outer join course on takes.course_id=course.course_id 
		WHERE id = x_id
		ORDER BY year,
		CASE semester
			WHEN 'Spring' THEN 1 
			WHEN 'Summer' THEN 2 
	    		WHEN 'Fall' THEN 3 ELSE 4
		END ASC;
        
BEGIN
	OPEN c1;
	LOOP
	FETCH c1 INTO x_dept_name;
	EXIT WHEN c1%NOTFOUND; 
    	dbms_output.put_line (x_dept_name); 
		OPEN c2;
		LOOP
		FETCH c2 INTO x_id, x_name; 
		EXIT WHEN c2%NOTFOUND;
		dbms_output.put_line ('       '||x_name);
		x_tot_credit := 0;
		x_gpa := 0;
		x_point := 0;
			OPEN c3;
			LOOP
			FETCH c3 INTO x_title, x_credits, x_semester, x_year, x_grade;
			EXIT WHEN c3%NOTFOUND;
			dbms_output.put_line ('          '||x_title||' '|| x_credits||' '||x_semester||' '||x_year||' '||x_grade);
			CASE x_grade
				WHEN 'A+' THEN x_point := 4.3;
				WHEN 'A' THEN x_point := 4; 
				WHEN 'A-' THEN x_point := 3.7; 
				WHEN 'B+' THEN x_point := 3.3; 
				WHEN 'B' THEN x_point := 3; 
				WHEN 'B-' THEN x_point := 2.7; 
				WHEN 'C+' THEN x_point := 2.4;
				WHEN 'C' THEN x_point := 2.1; 
				WHEN 'C-' THEN x_point := 1.8; 
				WHEN 'D+' THEN x_point := 1.5; 
				WHEN 'D' THEN x_point := 1.2; 
				WHEN 'D-' THEN x_point := 0.9;
				WHEN 'F' THEN x_point := 0;
				ELSE x_point := 0; x_credits := 0; -- grade NULL
			END CASE;
			x_tot_credit := x_tot_credit + x_credits; 
			x_gpa := x_gpa + x_credits*x_point;
			END LOOP;
			CASE
				WHEN x_tot_credit <> 0 THEN x_gpa := x_gpa / x_tot_credit; 
				ELSE x_gpa := 0;
			END CASE; 
			dbms_output.put_line ('          Total Credits: '||x_tot_credit||' GPA: '||x_gpa);
			CLOSE c3;
		END LOOP;
		CLOSE c2; 
	END LOOP;
	CLOSE c1; 
END;
