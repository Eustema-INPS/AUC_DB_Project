
--exec usp_compression  -- drop PROC [dbo].[usp_compression] 
CREATE PROC [dbo].[usp_compression_eap_alltable] 
(
  @minCompression float = null -- e.g. .25 for minimum of 25% compression
  )
as
begin
set nocount on 
/*
  sets compression for all objects and indexs in the database needing adjustment:
  
  - if estimated gain is equal to or greater than mincompression parameter
      then enables ROW or PAGE compression whichever is greater gain
  - if ROW and PAGE have same gain
      then enables ROW compression
  - if estimated gain is less than mincompression parameter 
      then compression is set to NONE
    
*/


  IF @minCompression is null SET @minCompression = .25 -- Change default HERE !!!

  CREATE TABLE #ObjEst (
    PK int identity not null primary key,
    object_name varchar(250) collate SQL_EBCDIC037_CP1_CS_AS,
    schema_name varchar(250) collate SQL_EBCDIC037_CP1_CS_AS,
    index_id INT,
    partition_number int,
    size_with_current_compression_setting bigint,
    size_with_requested_compression_setting bigint,
    sample_size_with_current_compression_setting bigint,
    sample_size_with_requested_compresison_setting bigint
    )
    
  CREATE TABLE #dbEstimate (
    PK int identity not null primary key,
    schema_name varchar(250) collate SQL_EBCDIC037_CP1_CS_AS ,
    object_name varchar(250) collate SQL_EBCDIC037_CP1_CS_AS,
    index_id INT,
    ixName VARCHAR(255) collate SQL_EBCDIC037_CP1_CS_AS,
    ixType VARCHAR(50) collate SQL_EBCDIC037_CP1_CS_AS,
    partition_number int,
    data_compression_desc VARCHAR(50) collate SQL_EBCDIC037_CP1_CS_AS,
    NONE_Size INT,
    ROW_Size INT,
    PAGE_Size INT
    )
  
  select * from sys.objects as O inner join sys.columns R on O.object_id=R.object_id and 
  R.system_type_id  in (select system_type_id from sys.types where system_type_id not in (165,240,241))
  --and O.name='st_idAbbinamento'
 
  INSERT INTO #dbEstimate (schema_name, object_name, index_id, ixName, ixType, partition_number, data_compression_desc)
      select distinct S.name, O.name, I.index_id, I.name, I.type_desc, P.partition_number,'PAGE'
        from sys.schemas as S
          join sys.objects as O
            on S.schema_id = O.schema_id 
          join sys.indexes as I
	          on O.object_id = I.object_id 
	        join sys.partitions as P
	          on I.object_id = P.object_id
	          and I.index_id= P.index_id
			  inner join sys.columns R on O.object_id=R.object_id and 
  R.system_type_id  in (select system_type_id from sys.types where system_type_id not in (165,240,241))
	       where O.type = 'U' and data_compression=0 and data_compression=0 
		   and O.name not in ('sysdiagrams')
		  except 
		        select distinct S.name, O.name, I.index_id, I.name, I.type_desc, P.partition_number,'PAGE'
        from sys.schemas as S
          join sys.objects as O
            on S.schema_id = O.schema_id 
          join sys.indexes as I
	          on O.object_id = I.object_id 
	        join sys.partitions as P
	          on I.object_id = P.object_id
	          and I.index_id= P.index_id
			  inner join sys.columns R on O.object_id=R.object_id and 
  R.system_type_id  in (select system_type_id from sys.types where system_type_id not in (165,240,241))
	       where O.type = 'U' and data_compression=0 and data_compression=0 
		   and (O.name not in ('sysdiagrams')	OR R.max_length = '-1')
		   

 -- Determine Compression Estimates 

 select * from sys.objects

  DECLARE
    @PK INT,
    @Schema varchar(150),
    @object varchar(150),
    @DAD varchar(25),
    @partNO int,
    @indexID int,
    @ixName VARCHAR(250),
    @SQL nVARCHAR(max),
    @ixType VARCHAR(50), 
    @Recommended_Compression VARCHAR(10)
   
/*   
   
 
  DECLARE cCompress CURSOR FAST_FORWARD
    FOR 
      select schema_name, object_name, index_id, partition_number, data_compression_desc       FROM #dbEstimate
   
  OPEN cCompress
  
  FETCH cCompress INTO @Schema, @object, @indexID, @partNO, @DAD  -- prime the cursor
 
  WHILE @@Fetch_Status = 0 
    BEGIN
        
    IF @DAD = 'NONE'
      BEGIN 
            -- estimate PAGE compression
            INSERT #ObjEst (object_name,schema_name,index_id,partition_number,size_with_current_compression_setting,size_with_requested_compression_setting,sample_size_with_current_compression_setting,sample_size_with_requested_compresison_setting )
              EXEC sp_estimate_data_compression_savings
                @schema_name = @Schema,
                @object_name = @object,
                @index_id = @indexID,
                @partition_number = @partNO,
                @data_compression = 'PAGE'
     
      
             UPDATE #dbEstimate
                SET NONE_size = O.size_with_current_compression_setting,
                    PAGE_size = O.size_with_requested_compression_setting
                FROM #dbEstimate D
                  JOIN #ObjEst O
                    ON  D.Schema_name = O.Schema_Name
                    and D.Object_name = O.object_name
                    and D.index_id = O.index_id
                    and D.partition_number = O.partition_number  
                    
             DELETE #ObjEst  
             
             -- estimate ROW compression
            INSERT #ObjEst (object_name,schema_name,index_id,partition_number,size_with_current_compression_setting,size_with_requested_compression_setting,sample_size_with_current_compression_setting,sample_size_with_requested_compresison_setting )
              EXEC sp_estimate_data_compression_savings
                @schema_name = @Schema,
                @object_name = @object,
                @index_id = @indexID,
                @partition_number = @partNO,
                @data_compression = 'ROW'
                
             UPDATE #dbEstimate
                SET ROW_size = O.size_with_requested_compression_setting
                FROM #dbEstimate D
                  JOIN #ObjEst O
                    ON  D.Schema_name = O.Schema_Name
                    and D.Object_name = O.object_name
                    and D.index_id = O.index_id
                    and D.partition_number = O.partition_number  
                    
             DELETE #ObjEst 
             
             
        END -- NONE compression estimate      
 
    IF @DAD = 'ROW'
      BEGIN 
            -- estimate PAGE compression
            INSERT #ObjEst (object_name,schema_name,index_id,partition_number,size_with_current_compression_setting,size_with_requested_compression_setting,sample_size_with_current_compression_setting,sample_size_with_requested_compresison_setting )
              EXEC sp_estimate_data_compression_savings
                @schema_name = @Schema,
                @object_name = @object,
                @index_id = @indexID,
                @partition_number = @partNO,
                @data_compression = 'PAGE'
                
             UPDATE #dbEstimate
                SET ROW_size = O.size_with_current_compression_setting,
                    PAGE_size = O.size_with_requested_compression_setting
                FROM #dbEstimate D
                  JOIN #ObjEst O
                    ON  D.Schema_name = O.Schema_Name
                    and D.Object_name = O.object_name
                    and D.index_id = O.index_id
                    and D.partition_number = O.partition_number  
                    
             DELETE #ObjEst  
             
             -- estimate NONE compression
            INSERT #ObjEst (object_name,schema_name,index_id,partition_number,size_with_current_compression_setting,size_with_requested_compression_setting,sample_size_with_current_compression_setting,sample_size_with_requested_compresison_setting )
              EXEC sp_estimate_data_compression_savings
                @schema_name = @Schema,
                @object_name = @object,
                @index_id = @indexID,
                @partition_number = @partNO,
                @data_compression = 'NONE'
                
             UPDATE #dbEstimate
                SET NONE_size = O.size_with_requested_compression_setting
                FROM #dbEstimate D
                  JOIN #ObjEst O
                    ON  D.Schema_name = O.Schema_Name
                    and D.Object_name = O.object_name
                    and D.index_id = O.index_id
                    and D.partition_number = O.partition_number  
                    
             DELETE #ObjEst       
        END -- ROW compression estimate     
      
    IF @DAD = 'PAGE'
      BEGIN 
            -- estimate ROW compression
            INSERT #ObjEst (object_name,schema_name,index_id,partition_number,size_with_current_compression_setting,size_with_requested_compression_setting,sample_size_with_current_compression_setting,sample_size_with_requested_compresison_setting )
              EXEC sp_estimate_data_compression_savings
                @schema_name = @Schema,
                @object_name = @object,
                @index_id = @indexID,
                @partition_number = @partNO,
                @data_compression = 'ROW'
                
             UPDATE #dbEstimate
                SET PAGE_size = O.size_with_current_compression_setting,
                    ROW_size = O.size_with_requested_compression_setting
                FROM #dbEstimate D
                  JOIN #ObjEst O
                    ON  D.Schema_name = O.Schema_Name
                    and D.Object_name = O.object_name
                    and D.index_id = O.index_id
                    and D.partition_number = O.partition_number  
                    
             DELETE #ObjEst  
             
             -- estimate NONE compression
            INSERT #ObjEst (object_name,schema_name,index_id,partition_number,size_with_current_compression_setting,size_with_requested_compression_setting,sample_size_with_current_compression_setting,sample_size_with_requested_compresison_setting )
              EXEC sp_estimate_data_compression_savings
                @schema_name = @Schema,
                @object_name = @object,
                @index_id = @indexID,
                @partition_number = @partNO,
                @data_compression = 'NONE'
                
             UPDATE #dbEstimate
                SET NONE_size = O.size_with_requested_compression_setting
                FROM #dbEstimate D
                  JOIN #ObjEst O
                    ON  D.Schema_name = O.Schema_Name
                    and D.Object_name = O.object_name
                    and D.index_id = O.index_id
                    and D.partition_number = O.partition_number  
                    
             DELETE #ObjEst       
        END -- PAGE compression estimate 
          
       FETCH cCompress INTO @Schema, @object, @indexID, @partNO, @DAD 
    END

  CLOSE cCompress
  DEALLOCATE cCompress
 */
 -- select * from #dbEstimate    --    where NONE_Size <> 0
       
 -- set the compression 
 DECLARE cCompress CURSOR FAST_FORWARD
    FOR 
      select schema_name, object_name, partition_number, ixName, ixType,  'PAGE'   as Recommended_Compression  from #dbEstimate 
      /*
       where NONE_Size <> 0
       and (Case 
           when (1-(cast(ROW_Size as float) / NONE_Size)) >= @minCompression and (ROW_Size <= PAGE_Size) then 'ROW' 
           when (1-(cast(PAGE_Size as float) / NONE_Size)) >= @minCompression and (PAGE_Size <= ROW_Size) then 'PAGE' 
           else 'NONE' 
         end 
         <> data_compression_desc)
   */
  OPEN cCompress
  
  FETCH cCompress INTO @Schema, @object, @partNO, @ixName, @ixType, @Recommended_Compression  -- prime the cursor
 
  WHILE @@Fetch_Status = 0 
    BEGIN
      --print @object
    
      IF @ixType = 'Clustered' or @ixType='heap'
      set @SQL = 'ALTER TABLE ' + @schema + '.[' + @object + '] Rebuild with (data_compression = ' + @Recommended_Compression + ', ONLINE=ON)'
      
      else 
      set @SQL = 'ALTER INDEX ' + @ixName + ' on ' + @schema + '.[' + @object + '] Rebuild with (data_compression = ' + @Recommended_Compression + ', ONLINE=ON)'

      print @SQL        
      
      EXEC sp_executesql @SQL
      
      FETCH cCompress INTO @Schema, @object, @partNO, @ixName, @ixType, @Recommended_Compression  -- prime the cursor
    END

  CLOSE cCompress
  DEALLOCATE cCompress
 
  RETURN
 end
 
