--�s�Wprocedure gen_seats
create procedure gen_seats (@v_ptime varchar(20),
							@v_movie int,
							@v_roomid varchar(10))
as
BEGIN
	DECLARE   @v_row     int;
	DECLARE   @v_col     int;
	DECLARE   @x_row     int;
	DECLARE   @x_col     int;

	--���d��  ���w�U�|���y��� row, col
	select @v_row = seat_row , @v_col = seat_col
	from   m_room
	where  @v_roomid = roomid

	--�ھڮy��� @v_row, @v_col ���ͮy���
	SET @x_row = 1;       
    WHILE ( @x_row  <= @v_row )
    BEGIN
		SET @x_col = 1;     
		WHILE ( @x_col  <= @v_col )
        BEGIN
			insert into seats values ( @v_ptime, @v_movie,
									   RIGHT('0' + cast( @x_row as varchar(2)), 2) + '-' + 
									   RIGHT('0' + cast( @x_col as varchar(2)), 2), '0', NULL);
			SET @x_col = @x_col + 1		--�W�[ @x_col
        END; 
        SET @x_row = @x_row + 1		--�W�[ @x_row
    END;
END;

--���տ�X���O
--����procedure gen_seats
exec gen_seats '2009-12-25 13:00', 1, 'A�U'

select * from seats where seat_num = '25-20'

--�R��procedure gen_seats
drop procedure gen_seats