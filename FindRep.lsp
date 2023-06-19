;By Jason Cheers
;
;Thanks for example source code:
;Lee Mac
;DannyNL @ AutoDesk Forums
;T.Willey @ AUGI Forums
;Help from many forum members accross multiple sites
;
; ************************************************************************


(defun c:FINDREP (oldStr newStr)
  
  (setq ss(ssget ))
  (JMC:FINDREPLACE ss oldStr newStr)
  (princ)
)

(defun c:FINDREPA (oldStr newStr)
  
  (setq ss (ssget "x"))
  (JMC:FINDREPLACE ss oldStr newStr)
  (princ)
)

(defun c:FINDREPEA ()
  (setq oldStrings '("LEFT1","LEFT2","LEFT3","LEFT4","LEFT5","LEFT6","LEFT7","LEFT8","LEFT9","LEFT10","LEFT11","LEFT12",
    "RIGHT1","RIGHT2","RIGHT3","RIGHT4","RIGHT5","RIGHT6","RIGHT7","RIGHT8","RIGHT9","RIGHT10","RIGHT11","RIGHT12",
    "POS1","POS2","POS3","POS4","POS5","POS6","POS7","POS8","POS9","POS10","POS11","POS12",
    "1","2","3","4","5","6","7","8","9","10","11","12"))
  (setq newStrings '("LEFT13","LEFT14","LEFT15","LEFT16","LEFT17","LEFT18","LEFT19","LEFT20","LEFT21","LEFT22","LEFT23","LEFT24",
    "RIGHT13","RIGHT14","RIGHT15","RIGHT16","RIGHT17","RIGHT18","RIGHT19","RIGHT20","RIGHT21","RIGHT22","RIGHT23","RIGHT24",
    "POS13","POS14","POS15","POS16","POS17","POS18","POS19","POS20","POS21","POS22","POS23","POS24",
    "13","14","15","16","17","18","19","20","21","22","23","24"))
  (setq ss (ssget "x"))
  (foreach fndVal oldStrings
    (setq repPos (vl-position fndVal oldStrings))
    (JMC:FINDREPLACE ss fndVal (nth repPos newStrings))
  )
  (princ)
)

(defun c:FINDREPEB ()
  (setq oldStrings '("LEFT1","LEFT2","LEFT3","LEFT4","LEFT5","LEFT6","LEFT7","LEFT8","LEFT9","LEFT10","LEFT11","LEFT12",
    "RIGHT1","RIGHT2","RIGHT3","RIGHT4","RIGHT5","RIGHT6","RIGHT7","RIGHT8","RIGHT9","RIGHT10","RIGHT11","RIGHT12",
    "POS1","POS2","POS3","POS4","POS5","POS6","POS7","POS8","POS9","POS10","POS11","POS12",
    "1","2","3","4","5","6","7","8","9","10","11","12"))
  (setq newStrings '("LEFT25","LEFT26","LEFT27","LEFT28","LEFT29","LEFT30","LEFT31","LEFT32","LEFT33","LEFT34","LEFT35","LEFT36",
    "RIGHT25","RIGHT26","RIGHT27","RIGHT28","RIGHT29","RIGHT30","RIGHT31","RIGHT32","RIGHT33","RIGHT34","RIGHT35","RIGHT36",
    "POS25","POS26","POS27","POS28","POS29","POS30","POS31","POS32","POS33","POS34","POS35","POS36",
    "25","26","27","28","29","30","31","32","33","34","35","36"))
  (setq ss (ssget "x"))
  (foreach fndVal oldStrings
    (setq repPos (vl-position fndVal oldStrings))
    (JMC:FINDREPLACE ss fndVal (nth repPos newStrings))
  )
  (princ)
)

(defun c:FINDREPEC ()
  (setq oldStrings '("LEFT1","LEFT2","LEFT3","LEFT4","LEFT5","LEFT6","LEFT7","LEFT8","LEFT9","LEFT10","LEFT11","LEFT12",
    "RIGHT1","RIGHT2","RIGHT3","RIGHT4","RIGHT5","RIGHT6","RIGHT7","RIGHT8","RIGHT9","RIGHT10","RIGHT11","RIGHT12",
    "POS1","POS2","POS3","POS4","POS5","POS6","POS7","POS8","POS9","POS10","POS11","POS12",
    "1","2","3","4","5","6","7","8","9","10","11","12"))
  (setq newStrings '("LEFT37","LEFT38","LEFT39","LEFT40","LEFT41","LEFT42","LEFT43","LEFT44","LEFT45","LEFT46","LEFT47","LEFT48",
    "RIGHT37","RIGHT38","RIGHT39","RIGHT40","RIGHT41","RIGHT42","RIGHT43","RIGHT44","RIGHT45","RIGHT46","RIGHT47","RIGHT48",
    "POS37","POS38","POS39","POS40","POS41","POS42","POS43","POS44","POS45","POS46","POS47","POS48",
    "37","38","39","40","41","42","43","44","45","46","47","48"))
  (setq ss (ssget "x"))
  (foreach fndVal oldStrings
    (setq repPos (vl-position fndVal oldStrings))
    (JMC:FINDREPLACE ss fndVal (nth repPos newStrings))
  )
  (princ)
)

(defun c:FINDREPED ()
  (setq oldStrings '("B01-","B02-","B03-","B04-","B05-","B06-","B07-","B08-","B09-","B10-","B11-","B12-","B13-","B14-","B15-","B16-"))
  (setq newStrings '("IN01-","IN02-","IN03-","IN04-","IN05-","IN06-","IN07-","IN08-","IN09-","IN10-","IN11-","IN12-","IN13-","IN14-","IN15-","IN16-"))  
  (setq ss (ssget "x"))
  (foreach fndVal oldStrings
    (setq repPos (vl-position fndVal oldStrings))
    (JMC:FINDREPLACE ss fndVal (nth repPos newStrings))
  )
  (princ)
)

(defun c:FINDREPEE ()
  (setq oldStrings '("IN01-","IN02-","IN03-","IN04-","IN05-","IN06-","IN07-","IN08-","IN09-","IN10-","IN11-","IN12-","IN13-","IN14-","IN15-","IN16-",
                     "IN01","IN02","IN03","IN04","IN05","IN06","IN07","IN08","IN09","IN10","IN11","IN12","IN13","IN14","IN15","IN16"))  
  (setq newStrings '("01-","02-","03-","04-","05-","06-","07-","08-","09-","10-","11-","12-","13-","14-","15-","16-",
                     "01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16"))
  (setq ss (ssget "x"))
  (foreach fndVal oldStrings
    (setq repPos (vl-position fndVal oldStrings))
    (JMC:FINDREPLACE ss fndVal (nth repPos newStrings))
  )
  (princ)
)

(defun c:FINDREPEF ()
  (setq oldStrings '("01-","02-","03-","04-","05-","06-","07-","08-","09-","10-","11-","12-","13-","14-","15-","16-","17-","18-","19-","20-","21-","22-","23-","24-",
                     "01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"))
  (setq newStrings '("25-","26-","27-","28-","29-","30-","31-","32-","33-","34-","35-","36-","37-","38-","39-","40-","41-","42-","43-","44-","45-","46-","47-","48-",
                     "25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48"))
  (setq ss (ssget ))
  (foreach fndVal oldStrings
    (setq repPos (vl-position fndVal oldStrings))
    (JMC:FINDREPLACE ss fndVal (nth repPos newStrings))
  )
  (princ)
)

(defun JMC:FINDREPLACE ( SB_Selection oldStr newStr / FA_BlkObject FA_Attributes FA_Return)
  (setq SB_FoundSel (ssadd))
  (setq SB_Count 0)
  (setq SB_Max (sslength SB_Selection))
  (while (< SB_Count SB_Max)
   (setq SB_Ent (ssname SB_Selection SB_Count))
   (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
   (if
     (and
        (or
          (= (vla-get-ObjectName FA_BlkObject) "AcDbMText")
          (= (vla-get-ObjectName FA_BlkObject)"AcDbText")
          (= (vla-get-ObjectName FA_BlkObject) "AcDbMLeader")
          (= (vla-get-ObjectName FA_BlkObject) "AcDbAttributeDefinition")
        )
        (not
          (and
           (= (type FA_BlkObject) 'VLA-OBJECT)
           (= (vla-get-ObjectName FA_BlkObject) "AcDbBlockReference")     
          )
        )
     )
      (progn
        (if
          (= (vla-get-ObjectName FA_BlkObject) "AcDbAttributeDefinition")
          (progn
            (if
              (equal (vla-get-PromptString FA_BlkObject) oldStr)
              (vla-put-PromptString FA_BlkObject newStr)
            )
            (if
              (equal (vla-get-TagString FA_BlkObject) oldStr)
              (vla-put-TagString FA_BlkObject newStr)
            )
          )
          (if
            (equal (vla-get-TextString FA_BlkObject) oldStr)
            (vla-put-TextString FA_BlkObject newStr)
          ) 
        )
      )
   )
   (setq SB_Count (1+ SB_Count))
  )
)
