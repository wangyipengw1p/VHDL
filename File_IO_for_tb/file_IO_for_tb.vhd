
	-- read test data from a file using a process:
	
	read_input: process
	     type char_file is file of character;
	     file c_file_handle: char_file;
	     variable C: std_ulogic;
	     variable char_count: integer := 0;
	begin
	     file_open(c_file_handle, "test_file.txt", READ_MODE);
	     while not endfile(c_file_handle) loop
	         read (c_file_handle, C) ;
	         char_count = char_count + 1;  -- Keep track of the number of
	     -- characters
	     end loop;
	     file_close(c_file_handle);
	end process;

	-- write test data from a file using a process:

	write_input: process
	     type char_file is file of character;
	     file c_file_handle: char_file;
	     variable C: std_ulogic := '0';
	     constant char_count: integer := 0;
	begin
	     file_open(c_file_handle, "test_file.txt", WRITE_MODE);
	     while not endfile(c_file_handle) loop
	         write (c_file_handle, C) ;
	         char_count = char_count + 1;  -- Keep track of the number of
	     -- characters
	     end loop;
	     file_close(c_file_handle);
	end process;