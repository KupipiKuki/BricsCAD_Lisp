(defun jc:syncfile (fromDir toDir / fileList toFileList isDir fileItem cpType)
  (setq isDir (vl-directory-files toDir))
  (setq fileList ( vl-directory-files fromDir nil 1 ))
  
  (if fileList
    (progn
      (if
        (not
          isDir
        )
        (progn
          (vl-mkdir toDir)
          (princ "Destination Directory Not Found, Creating It.\n")
        )
        (setq toFileList (vl-directory-files toDir nil 1))
      )
      (foreach fileItem fileList
        (setq cpType (jc:timecompare (vl-file-systime (strcat fromDir fileItem)) (vl-file-systime (strcat toDir fileItem))))
        (if
          (> cpType 0)
          (progn
            (if
              (= cpType 1)
              (progn
                (princ fileItem)
                (princ " is Modified, Copying..\n")
                (vl-file-delete (strcat toDir fileItem))
                (vl-file-copy (strcat fromDir fileItem) (strcat toDir fileItem))
              )
              (progn
                (princ fileItem)
                (princ " is New, Copying..\n")
                (vl-file-copy (strcat fromDir fileItem) (strcat toDir fileItem))
              )
            )
          )
          (progn
            (if
              (= cpType -3)
              (progn
                (princ fileItem)
                (princ " local file is synced or has been modified, Skipping..\n")
              )
              (progn
                (princ fileItem)
                (princ " is not modified, Skipping..\n")
              )
            )
          )
        )
      )
      (princ "Process Completed\n")
    )
    (princ "Error In Source Directory, Exiting...\n")
  )
  (princ)
)

(defun jc:timeCompare ( a b / inLoop retVal)
  (if (= b nil)
    (setq retVal 2)
    (progn
      (if (= a nil)
        (setq retVal -2)
        (progn
          (if 
            (not
              (= a b)
            )
            (progn
              (setq inLoop 0)
              (while (> inLoop -1)
                (if
                  (and
                    (/= inLoop 2)
                    (> (nth inLoop a)(nth inLoop b))
                  )
                  (progn
                    (setq inLoop -1)
                    (setq retVal 1)
                  )
                  (progn
                    (if
                      (and
                        (/= inLoop 2)
                        (> (nth inLoop b)(nth inLoop a))
                      )
                      (progn
                        (setq inLoop -1)
                        (setq retVal -3)
                      )
                      (setq inLoop (+ inLoop 1))
                    )
                  )
                )
                (if (= inLoop 8)
                  (progn
                    (setq inLoop -1)
                    (setq retVal -1)
                  )
                )
              )
            )
            (setq retVal 0)
          )
        )
      )
    )
  )
  retVal
)