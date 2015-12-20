(setq sql-product 'postgres)
(setq sql-connection-alist '(("social-dev"
                              (sql-product 'postgres)
                              (sql-server "localhost")
                              (sql-port 5432)
                              (sql-database "social")
                              (sql-user "social"))

                             ("social-qa"
                              (sql-product 'postgres)
                              (sql-server "localhost")
                              (sql-port 5434)
                              (sql-database "social")
                              (sql-user "social"))

                             ("social-v1"
                              (sql-product 'postgres)
                              (sql-server "localhost")
                              (sql-port 5436)
                              (sql-database "social")
                              (sql-user "social"))

                             ("social-beta1"
                              (sql-product 'postgres)
                              (sql-server "localhost")
                              (sql-port 5437)
                              (sql-database "social")
                              (sql-user "social"))

                             ("social-beta2"
                              (sql-product 'postgres)
                              (sql-server "localhost")
                              (sql-port 5438)
                              (sql-database "social")
                              (sql-user "social")))
            sql-send-terminator t)
