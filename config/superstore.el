(setq sql-product 'postgres)
(setq sql-connection-alist '(("social-dev"
                              (sql-product 'postgres)
                              (sql-server "localhost")
                              (sql-port 5432)
                              (sql-database "social")
                              (sql-user "social"))

                             ("social-live"
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
                              (sql-user "social"))

                             ("social-beta3"
                              (sql-product 'postgres)
                              (sql-server "localhost")
                              (sql-port 5439)
                              (sql-database "social")
                              (sql-user "social")))
            sql-send-terminator t)
