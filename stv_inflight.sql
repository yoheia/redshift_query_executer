select '\'s3://redshift-unload-az/stv_inflight/stv_inflight_'||to_char(getdate(), 'YYYYMMDD-HH24MISS')||'\'' as s3_path;
\gset
unload ('select * from stv_inflight')   
to :s3_path
iam_role 'arn:aws:iam::542203247656:role/redshift-spectrum-s3-fullaccess'
format as csv
gzip 
allowoverwrite;
\watch 60