;;; build-site.el --- Export this site from Org. -*- lexical-binding: t; -*-

(require 'ox-html)

(setq org-html-doctype "html5"
      org-html-html5-fancy t
      org-html-validation-link nil
      org-html-postamble nil
      org-export-with-smart-quotes t
      org-export-with-broken-links 'mark)

(defun site-org-files (root)
  "Return top-level Org files under ROOT."
  (directory-files root t "\\.org\\'"))

(defun site-export-file (source)
  "Export SOURCE to the HTML file requested by its Org metadata."
  (message "Exporting %s" (file-name-nondirectory source))
  (with-current-buffer (find-file-noselect source)
    (let ((org-export-use-babel nil))
      (org-mode)
      (org-html-export-to-html)))
  (message "Exported %s" (file-name-nondirectory source)))

(let ((root (file-name-directory (or load-file-name buffer-file-name default-directory))))
  (dolist (source (site-org-files root))
    (site-export-file source)))
