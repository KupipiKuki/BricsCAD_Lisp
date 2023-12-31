(defun c:copyatt ( )
  (setq ss(ssget ))
  (JMC:COPYPASTE ss)
  (princ)
)

(defun JMC:COPYPASTE ( SB_Selection / FA_BlkObject FA_Attributes FA_Return)
  (setq SB_FoundSel (ssadd))
  (setq SB_Count 0)
  (setq SB_Max (sslength SB_Selection))
  (while (< SB_Count SB_Max)
   (setq SB_Ent (ssname SB_Selection SB_Count))
   (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
   (if
      (or
        (= (vla-get-ObjectName FA_BlkObject) "AcDbMText")
        (= (vla-get-ObjectName FA_BlkObject)"AcDbText")
        (= (vla-get-ObjectName FA_BlkObject) "AcDbMLeader")
        (= (vla-get-ObjectName FA_BlkObject) "AcDbAttributeDefinition")
      )
      (progn
        (princ "\n")
        (princ (vla-get-PromptString FA_BlkObject))
        (princ "\n")
        (setq FA_NewObject (vla-copy FA_BlkObject))
        (vla-delete FA_BlkObject)
      )
   )
   (setq SB_Count (1+ SB_Count))
  )
)
