;Modified by JCHEERS
;Written by Mark and Modified by Kevin Nehls on the Autodesk forums
;
;******************************************************************
(defun C:PURGEALL (/ Count ttlCount)
	(setq Count 0)
	(setq ttlCount 0 )
	(while (/= 0
			(setq Count 
				(
					(lambda (/ Count)
							(setq Count 0)
							(command "._-PURGE" "_A" "*" "Y")
							(while (not (zerop (getvar "CMDACTIVE")))
								(command "_Y")
								(setq Count (1+ Count))
							)
							Count
					)
				)
			)
		)
		(setq ttlCount (+ ttlCount Count))
	)
	(if (/= ttlCount 0)
		(princ
			(strcat
				"\nPurge completed, total of "
				(itoa ttlCount)
				" item(s) purged."
			)
		)
		(princ "\nNothing to purge.")
	)
	(princ)
)