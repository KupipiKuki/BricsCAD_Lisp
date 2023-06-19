;By Jason Cheers
;
;Thanks for example source code:
;Lee Mac
;DannyNL @ AutoDesk Forums
;T.Willey @ AUGI Forums
;Help from many forum members accross multiple sites
;
; ************************************************************************


(defun c:ESBLK ()
  
  (setq ss(ssget ))
  (JMC:ExplodeAll ss 'pstylemode)
  (princ)
)

(defun c:ESBLKA ( )
  
  (setq ss (ssget "x"))
  (JMC:ExplodeAll ss 'pstylemode)
  (princ)
)

(defun c:ESBLKAL ( ltab )
  (princ ltab)
  (setq ss (ssget "_x" (list (cons 410 ltab))))
  (JMC:ExplodeAllLayout ss 'pstylemode ltab)
  (princ)
)

(defun JMC:ExplodeAll ( SB_Selection psm / FA_BlkObject FA_Attributes FA_Return)
  (setq SB_FoundSel (ssadd))
  (setq SB_Count 0)
  (setq SB_Max (sslength SB_Selection))
  (if (zerop (getvar "pstylemode")) 
    (progn
      (princ "STB File Detected\n")
      (while (< SB_Count SB_Max)
       (setq SB_Ent (ssname SB_Selection SB_Count))
       (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
       (cond
         ((= "Remove" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 3))
         ((= "Add" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 1))
         ((= "Existing" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 0))
         ((= "AsBuilt" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 4))
         ((= "Revision" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 6))
       )
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
                  (if (= (vla-get-invisible FA_Item) :vlax-false)
                    (progn
                      (setq mspace (vla-get-modelspace (vla-get-activedocument (vlax-get-acad-object))))
                      (setq TextObj (vla-AddText mspace (vla-get-TextString FA_Item) (vla-get-InsertionPoint FA_Item) (vla-get-Height FA_Item)))
                      (vla-put-Alignment TextObj (vla-get-Alignment FA_Item))
                      (if (/= (vla-get-Alignment TextObj) 0)
                        (vla-put-TextAlignmentPoint TextObj (vla-get-TextAlignmentPoint FA_Item))
                      )
                      (vla-put-Backward TextObj (vla-get-Backward FA_Item))
                      (vla-put-Layer TextObj (vla-get-Layer FA_Item))
                      (vla-put-Normal TextObj (vla-get-Normal FA_Item))
                      (vla-put-ObliqueAngle TextObj (vla-get-ObliqueAngle FA_Item))
                      (vla-put-Rotation TextObj (vla-get-Rotation FA_Item))
                      (vla-put-ScaleFactor TextObj (vla-get-ScaleFactor FA_Item))
                      (vla-put-StyleName TextObj (vla-get-StyleName FA_Item))
                      (vla-put-UpsideDown TextObj (vla-get-UpsideDown FA_Item))
                      (vla-put-plotstylename TextObj (vla-get-plotstylename FA_BlkObject))
                      (vla-put-color TextObj (vla-get-color FA_BlkObject))
                    )
                  )
                )
              )
            )
            ;(vla-explode FA_BlkObject)
            ;(princ (vla-get-Name FA_BlkObject))
            ;(princ (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
            (setq EX_Selection (vla-explode FA_BlkObject))
            (if (not (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
                (progn
                  (setq ss (vlax-safearray->list (vlax-variant-value EX_Selection ) ) )
                  (foreach ssitem ss
                    (setq ssattn (vla-get-ObjectName ssitem))
                    (if (= (vla-get-ObjectName ssitem) "AcDbAttributeDefinition")
                      (vla-delete ssitem)
                      (progn
                                    (vla-put-plotstylename ssitem (vla-get-plotstylename FA_BlkObject))
                        (vla-put-color ssitem (vla-get-color FA_BlkObject))
                      )
                    )
                  )
                )
            )
            (vla-delete FA_BlkObject)
          )
       )
       (setq SB_Count (1+ SB_Count))
      )
    )
    (progn
      (princ "CTB File Detected\n")
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
                  (if (= (vla-get-invisible FA_Item) :vlax-false)
                    (progn
                      (setq mspace (vla-get-modelspace (vla-get-activedocument (vlax-get-acad-object))))
                      (setq TextObj (vla-AddText mspace (vla-get-TextString FA_Item) (vla-get-InsertionPoint FA_Item) (vla-get-Height FA_Item)))
                      (vla-put-Alignment TextObj (vla-get-Alignment FA_Item))
                      (if (/= (vla-get-Alignment TextObj) 0)
                        (vla-put-TextAlignmentPoint TextObj (vla-get-TextAlignmentPoint FA_Item))
                      )
                      (vla-put-Backward TextObj (vla-get-Backward FA_Item))
                      (vla-put-Layer TextObj (vla-get-Layer FA_Item))
                      (vla-put-Normal TextObj (vla-get-Normal FA_Item))
                      (vla-put-ObliqueAngle TextObj (vla-get-ObliqueAngle FA_Item))
                      (vla-put-Rotation TextObj (vla-get-Rotation FA_Item))
                      (vla-put-ScaleFactor TextObj (vla-get-ScaleFactor FA_Item))
                      (vla-put-StyleName TextObj (vla-get-StyleName FA_Item))
                      (vla-put-UpsideDown TextObj (vla-get-UpsideDown FA_Item))
                    )
                  )
                )
              )
            )
            ;(vla-explode FA_BlkObject)
            ;(princ (vla-get-Name FA_BlkObject))
            ;(princ (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
            (setq EX_Selection (vla-explode FA_BlkObject))
            (if (not (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
                (progn
                  (setq ss (vlax-safearray->list (vlax-variant-value EX_Selection ) ) )
                  (foreach ssitem ss
                    (setq ssattn (vla-get-ObjectName ssitem))
                    (if (= (vla-get-ObjectName ssitem) "AcDbAttributeDefinition")
                      (vla-delete ssitem)
                    )
                  )
                )
            )
            (vla-delete FA_BlkObject)
          )
       )
       (setq SB_Count (1+ SB_Count))
      )
    )
  )
)





(defun JMC:ExplodeAllLayout ( SB_Selection psm ltab / FA_BlkObject FA_Attributes FA_Return)
  (setq SB_FoundSel (ssadd))
  (setq SB_Count 0)
  (setq SB_Max (sslength SB_Selection))
  (if (zerop (getvar "pstylemode")) 
    (progn
      (princ "STB File Detected\n")
      (while (< SB_Count SB_Max)
       (setq SB_Ent (ssname SB_Selection SB_Count))
       (setq FA_BlkObject (vlax-ename->vla-object (ssname SB_Selection SB_Count)))
       (cond
         ((= "Remove" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 3))
         ((= "Add" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 1))
         ((= "Existing" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 7))
         ((= "AsBuilt" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 4))
         ((= "Revision" (vla-get-plotstylename FA_BlkObject))(vla-put-color FA_BlkObject 6))
       )
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
                  (if (= (vla-get-invisible FA_Item) :vlax-false)
                    (progn
                      (if (= "model" ltab)
                        (progn
                          (setq mspace (vla-get-modelspace (vla-get-activedocument (vlax-get-acad-object))))
                          (setq TextObj (vla-AddText mspace (vla-get-TextString FA_Item) (vla-get-InsertionPoint FA_Item) (vla-get-Height FA_Item)))
                        )
                        (progn
                          (setq pspace (vla-get-block (vla-item (vla-get-layouts (vla-get-activedocument (vlax-get-acad-object))) ltab)))
                          (setq doc (vla-get-activedocument (vlax-get-acad-object)))
                          (setq TextObj
                            (vlax-invoke-method
                              (vla-get-block
                                (vla-item
                                  (vla-get-layouts doc)
                                  (getvar 'ctab)
                                )
                              )
                              'addtext (vla-get-TextString FA_Item) (vla-get-InsertionPoint FA_Item) (vla-get-Height FA_Item)
                            )
                          )
                        )
                      )		      
                      (vla-put-Alignment TextObj (vla-get-Alignment FA_Item))
                      (if (/= (vla-get-Alignment TextObj) 0)
                        (vla-put-TextAlignmentPoint TextObj (vla-get-TextAlignmentPoint FA_Item))
                      )
                      (vla-put-Backward TextObj (vla-get-Backward FA_Item))
                      (vla-put-Layer TextObj (vla-get-Layer FA_Item))
                      (vla-put-Normal TextObj (vla-get-Normal FA_Item))
                      (vla-put-ObliqueAngle TextObj (vla-get-ObliqueAngle FA_Item))
                      (vla-put-Rotation TextObj (vla-get-Rotation FA_Item))
                      (vla-put-ScaleFactor TextObj (vla-get-ScaleFactor FA_Item))
                      (vla-put-StyleName TextObj (vla-get-StyleName FA_Item))
                      (vla-put-UpsideDown TextObj (vla-get-UpsideDown FA_Item))
                      (vla-put-plotstylename TextObj (vla-get-plotstylename FA_BlkObject))
                      (vla-put-color TextObj (vla-get-color FA_BlkObject))
                    )
                  )
                )
              )
            )
            ;(vla-explode FA_BlkObject)
            ;(princ (vla-get-Name FA_BlkObject))
            ;(princ (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
            (setq EX_Selection (vla-explode FA_BlkObject))
            (if (not (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
                (progn
                  (setq ss (vlax-safearray->list (vlax-variant-value EX_Selection ) ) )
                  (foreach ssitem ss
                    (setq ssattn (vla-get-ObjectName ssitem))
                    (if (= (vla-get-ObjectName ssitem) "AcDbAttributeDefinition")
                      (vla-delete ssitem)
                      (progn
                        (vla-put-plotstylename ssitem (vla-get-plotstylename FA_BlkObject))
                        (vla-put-color ssitem (vla-get-color FA_BlkObject))
                      )
                    )
                  )
                )
            )
            (vla-delete FA_BlkObject)
          )
       )
       (setq SB_Count (1+ SB_Count))
      )
    )
    (progn
      (princ "CTB File Detected\n")
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
                  (if (= (vla-get-invisible FA_Item) :vlax-false)
                    (progn
                      (if (= "model" ltab)
                        (progn
                          (setq mspace (vla-get-modelspace (vla-get-activedocument (vlax-get-acad-object))))
                                            (setq TextObj (vla-AddText mspace (vla-get-TextString FA_Item) (vla-get-InsertionPoint FA_Item) (vla-get-Height FA_Item)))
                        )
                        (progn
                          (setq pspace (vla-get-block (vla-item (vla-get-layouts (vla-get-activedocument (vlax-get-acad-object))) ltab)))
                                            (setq TextObj (vlax-invoke pspace 'addtext (vla-get-TextString FA_Item) (vla-get-InsertionPoint FA_Item) (vla-get-Height FA_Item)))
                        )
                      )
                      (vla-put-Alignment TextObj (vla-get-Alignment FA_Item))
                      (if (/= (vla-get-Alignment TextObj) 0)
                        (vla-put-TextAlignmentPoint TextObj (vla-get-TextAlignmentPoint FA_Item))
                      )
                      (vla-put-Backward TextObj (vla-get-Backward FA_Item))
                      (vla-put-Layer TextObj (vla-get-Layer FA_Item))
                      (vla-put-Normal TextObj (vla-get-Normal FA_Item))
                      (vla-put-ObliqueAngle TextObj (vla-get-ObliqueAngle FA_Item))
                      (vla-put-Rotation TextObj (vla-get-Rotation FA_Item))
                      (vla-put-ScaleFactor TextObj (vla-get-ScaleFactor FA_Item))
                      (vla-put-StyleName TextObj (vla-get-StyleName FA_Item))
                      (vla-put-UpsideDown TextObj (vla-get-UpsideDown FA_Item))
                    )
                  )
                )
              )
            )
            ;(vla-explode FA_BlkObject)
            ;(princ (vla-get-Name FA_BlkObject))
            ;(princ (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
            (setq EX_Selection (vla-explode FA_BlkObject))
            (if (not (wcmatch (vla-get-Name FA_BlkObject)  "`**"))
                (progn
                  (setq ss (vlax-safearray->list (vlax-variant-value EX_Selection ) ) )
                  (foreach ssitem ss
                    (setq ssattn (vla-get-ObjectName ssitem))
                    (if (= (vla-get-ObjectName ssitem) "AcDbAttributeDefinition")
                      (vla-delete ssitem)
                    )
                  )
                )
            )
            (vla-delete FA_BlkObject)
          )
       )
       (setq SB_Count (1+ SB_Count))
      )
    )
  )
)