# pg tps test
 ### 安装压测工具
 ```
 $ yum provides pgbench
 $ yum install postgresql-contrib-9.2.24-1.el7_5.x86_64 -y
 ```
 ### 初始化数据库和数据
  ```
# pgbench -i postgres -h 10.0.252.4 -p 5432 -U root
Password: 
NOTICE:  table "pgbench_branches" does not exist, skipping
NOTICE:  table "pgbench_tellers" does not exist, skipping
NOTICE:  table "pgbench_accounts" does not exist, skipping
NOTICE:  table "pgbench_history" does not exist, skipping
creating tables...
10000 tuples done.
20000 tuples done.
30000 tuples done.
40000 tuples done.
50000 tuples done.
60000 tuples done.
70000 tuples done.
80000 tuples done.
90000 tuples done.
100000 tuples done.
set primary key...
vacuum...done.
  ```
### 开始压测（100个连接，持续5分钟）
```
# pgbench -M simple -c 100 -T 300 -r postgres -h 10.0.252.4 -p 5432 -U root   
Password: 
starting vacuum...end.
transaction type: TPC-B (sort of)
scaling factor: 1
query mode: simple
number of clients: 100
number of threads: 1
duration: 300 s
number of transactions actually processed: 80002
tps = 266.363001 (including connections establishing)
tps = 266.567761 (excluding connections establishing)
statement latencies in milliseconds:
        0.003147        \set nbranches 1 * :scale
        0.001029        \set ntellers 10 * :scale
        0.000947        \set naccounts 100000 * :scale
        0.001071        \setrandom aid 1 :naccounts
        0.000745        \setrandom bid 1 :nbranches
        0.000783        \setrandom tid 1 :ntellers
        0.000837        \setrandom delta -5000 5000
        0.214053        BEGIN;
        0.720584        UPDATE pgbench_accounts SET abalance = abalance + :delta WHERE aid = :aid;
        0.264119        SELECT abalance FROM pgbench_accounts WHERE aid = :aid;
        337.067165      UPDATE pgbench_tellers SET tbalance = tbalance + :delta WHERE tid = :tid;
        33.029945       UPDATE pgbench_branches SET bbalance = bbalance + :delta WHERE bid = :bid;
        0.272125        INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (:tid, :bid, :aid, :delta, CURRENT_TIMESTAMP);
        3.336927        END;
```
