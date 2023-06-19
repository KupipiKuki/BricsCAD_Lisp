;By Jason Cheers
;
;Thanks for example source code:
;Lee Mac
;DannyNL @ AutoDesk Forums
;Help from many forum members accross multiple sites
;
; ************************************************************************

(defun LM:ApplytoBlockObjects ( blks name func / def result )
    (setq func (eval func))
    (if (not (vl-catch-all-error-p (setq def (vl-catch-all-apply 'vla-item (list blks name)))))
        (vlax-for obj def (setq result (cons (func obj) result)))
    )
    (reverse result)
)

(defun c:MMBL ( / FA_BlkObject FA_Attributes FA_Return)
  
 (setq SB_Selection (ssget ))
 (setq SB_FoundSel (ssadd))
 (setq SB_Count 0)
 (setq SB_Max (sslength SB_Selection))
  (while (< SB_Count SB_Max)
   (setq SB_Ent (ssname SB_Selection SB_Count))
   (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
   (if
      (and
         (= (type FA_BlkObject) 'VLA-OBJECT)
         (= (vla-get-ObjectName FA_BlkObject) "AcDbBlockReference")     
      )
      (progn
        (if
	  (= (vla-get-HasAttributes FA_BlkObject) :vlax-true)
	  (progn
	    (setq FA_Attributes (vlax-safearray->list (vlax-variant-value (vla-GetAttributes FA_BlkObject))))
	    (foreach FA_Item FA_Attributes
	      (if
	        (= (vla-get-invisible FA_Item) :vlax-false)
		(vla-put-color FA_Item 256)
              )
            )
          )
	)
        (LM:ApplytoBlockObjects
          (vla-get-blocks (vla-get-activedocument (vlax-get-acad-object)))
          (vla-get-effectivename FA_BlkObject)
         '(lambda ( obj ) (vla-put-color obj 256))
        )
      )
      (progn
        (vla-put-color FA_BlkObject 256)
      )
   )
   (setq SB_Count (1+ SB_Count))
    (if
      (> (sslength SB_FoundSel) 0)
      (sssetfirst nil SB_FoundSel)
    )
 )
)

(defun c:SAMBL ( / FA_BlkObject FA_Attributes FA_Return)
  
 (setq SB_Selection (ssget "x"))
 (setq SB_Selected (ssadd))
 (setq SB_FoundSel (ssadd))
 (setq SB_Count 0)
 (setq SB_Max (sslength SB_Selection))
  (while (< SB_Count SB_Max)
   (setq SB_Ent (ssname SB_Selection SB_Count))
   (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
   (if
      (= (vla-get-color FA_BlkObject) 256)
      (ssadd (ssname SB_Selection SB_Count) SB_Selected)
   )
   (setq SB_Count (1+ SB_Count))
    (if
      (> (sslength SB_FoundSel) 0)
      (sssetfirst nil SB_FoundSel)
    )
 )
 (setq SB_Selection nil)
 (sssetfirst nil SB_Selected)
)

(defun c:MMCL ( / FA_BlkObject FA_Attributes FA_Return)
	(setq mycolor (acad_colordlg 256 T))
	(if (not mycolor) 
		(setq mycolor 256)
	)
 (setq SB_Selection (ssget ))
 (setq SB_FoundSel (ssadd))
 (setq SB_Count 0)
 (setq SB_Max (sslength SB_Selection))
  (while (< SB_Count SB_Max)
   (setq SB_Ent (ssname SB_Selection SB_Count))
   (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
   (if
      (and
         (= (type FA_BlkObject) 'VLA-OBJECT)
         (= (vla-get-ObjectName FA_BlkObject) "AcDbBlockReference")     
      )
      (progn
        (if
	  (= (vla-get-HasAttributes FA_BlkObject) :vlax-true)
	  (progn
	    (setq FA_Attributes (vlax-safearray->list (vlax-variant-value (vla-GetAttributes FA_BlkObject))))
	    (foreach FA_Item FA_Attributes
	      (if
	        (= (vla-get-invisible FA_Item) :vlax-false)
		(vla-put-color FA_Item mycolor)
              )
            )
          )
	)
        (LM:ApplytoBlockObjects
          (vla-get-blocks (vla-get-activedocument (vlax-get-acad-object)))
          (vla-get-effectivename FA_BlkObject)
         '(lambda ( obj ) (vla-put-color obj mycolor))
        )
      )
      (progn
        (vla-put-color FA_BlkObject mycolor)
      )
   )
   (setq SB_Count (1+ SB_Count))
    (if
      (> (sslength SB_FoundSel) 0)
      (sssetfirst nil SB_FoundSel)
    )
 )
)

(defun c:SAMCL ( / FA_BlkObject FA_Attributes FA_Return)
  	(setq mycolor (acad_colordlg 256 T))
	(if (not mycolor) 
		(setq mycolor 256)
	)
 (setq SB_Selection (ssget "x"))
 (setq SB_Selected (ssadd))
 (setq SB_FoundSel (ssadd))
 (setq SB_Count 0)
 (setq SB_Max (sslength SB_Selection))
  (while (< SB_Count SB_Max)
   (setq SB_Ent (ssname SB_Selection SB_Count))
   (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
   (if
      (= (vla-get-color FA_BlkObject) mycolor)
      (ssadd (ssname SB_Selection SB_Count) SB_Selected)
   )
   (setq SB_Count (1+ SB_Count))
    (if
      (> (sslength SB_FoundSel) 0)
      (sssetfirst nil SB_FoundSel)
    )
 )
 (setq SB_Selection nil)
 (sssetfirst nil SB_Selected)
)
