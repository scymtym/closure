(defpackage :glue
  (:use :clue :glisp)

  (:import-from "WS/GRAPHICS-UTILITIES"
                #:region 
                #:region-p
                #:make-rectangle*
                #:region-union
                #:region-intersection
                #:region-difference
                #:+nowhere+
                #:+everywhere+
                #:region-contains-position-p
                #:region-intersects-rectangle-p
                #:region-to-x11-rectangle-list
                #:map-region-rectangles
                #:translate-region
                )

  
  (:export
   #:*default-background*
   #:*default-dark-background*
   #:*default-font*
   #:*default-italic-font*
   #:*default-bold-font*
   #:*popup-sticky-delay*
   
   #:draw-line*
   #:draw-polygon*
   #:draw-rectangle*
   #:draw-text*
   #:draw-bordered-polygon
   #:draw-simple-border
   #:draw-complex-border
   #:3d-dark-color
   #:3d-light-color
   #:contact-size
   #:move-resize
   #:draw-up-arrow
   #:draw-down-arrow
   #:draw-left-arrow
   #:draw-right-arrow
   #:draw-diamond
   #:draw-text-into-box
   
   #:3d
   #:left-leading
   #:right-leading
   #:top-leading
   #:bottom-leading
   #:interior-rectangle*
   #:shadow-style
   #:interior-width
   #:interior-height

   #:label
   #:label-string
   #:label-alignment
   #:label-foreground
   #:label-font

   #:button

   #:menu-item
   #:popup-menu-item
   #:mi-enter
   #:mi-leave
   #:mi-activate
   
   #:popup-menu-button
   #:popup-button
   #:menu-button

   #:separator
   #:horizontal-separator
   #:vertical-separator

   #:scrollbar
   #:vertical-scrollbar
   #:horizontal-scrollbar
   #:thumb-pos
   #:thumb-size

   #:grid
   #:make-grid-pans

   #:menu-bar
   
   #:sle
   #:sle-font
   #:sle-string

   #:scrolled-window
   #:scrolled-window-viewport
   #:scrolled-window-horizontal-scrollbar
   #:scrolled-window-vertical-scrollbar

   #:radio-button
   #:radio-button-toggle-state

   #:font-ascent
   #:font-descent
   #:text-width
   #:char-width
   #:draw-glyphs
   #:afont

   #:progress-bar
   #:progress-bar-value

   #:find-contact
   #:contact-hierarchy
   #:new-list-box
   #:vbox
   #:hbox
   
   ;;defined in glue-mle.lisp
   #:text-area
   #:text-area-string

   ;;
   #:canvas
   
   ;; re-exports
   #:region 
   #:region-p
   #:make-rectangle*
   #:region-union
   #:region-intersection
   #:region-difference
   #:+nowhere+
   #:+everywhere+
   #:region-contains-position-p
   #:region-intersects-rectangle-p
   #:region-to-x11-rectangle-list
   #:map-region-rectangles

   ;;;;;
   
   ;; item protocol
   #:item-size
   #:item-paint
   ;; list-box
   #:list-box
   #:items
   )
  
  ;; re-export from CLUE
  (:export
   #:*contact*
   #:*database*
   #:*default-display*
   #:*default-host*
   #:*default-multipress-delay-limit*
   #:*default-multipress-verify-p*
   #:*parent*
   #:*remap-events*
   #:*restrict-events*
   #:0%gray
   #:100%gray
   #:12%gray
   #:12%grayr
   #:25%gray
   #:25%grayr
   #:33%gray
   #:37%gray
   #:37%grayr
   #:50%gray
   #:50%grayr
   #:6%gray
   #:6%grayr
   #:62%gray
   #:62%grayr
   #:66%gray
   #:75%gray
   #:75%grayh
   #:75%grayr
   #:88%gray
   #:88%grayr
   #:93%gray
   #:93%grayr
   #:above-sibling
   #:accept-focus-p
   #:add-before-action
   #:add-callback
   #:add-child
   #:add-event
   #:add-mode
   #:add-timer
   #:ancestor-p
   #:append-characters
   #:apply-action
   #:apply-callback
   #:apply-callback-else
   #:arrow-cursor
   #:background
   #:based-arrow-down-cursor
   #:based-arrow-up-cursor
   #:basic-contact
   #:boat-cursor
   #:bogosity-cursor
   #:border-width
   #:bottom-left-corner-cursor
   #:bottom-right-corner-cursor
   #:bottom-side-cursor
   #:bottom-tee-cursor
   #:box-spiral-cursor
   #:call-action
   #:callback-p
   #:callbacks
   #:center-ptr-cursor
   #:change-geometry
   #:change-layout
   #:change-priority
   #:check-function
   #:child
   #:children
   #:circle-cursor
   #:class-constraints
   #:class-resources
   #:clear
   #:clear-characters
   #:clock-cursor
   #:code
   #:coffee-mug-cursor
   #:complete-class
   #:complete-name
   #:composite
   #:composite-children
   #:composite-focus
   #:composite-shells
   #:compress-exposures
   #:compress-motion
   #:configure-p
   #:contact
   #:contact-background
   #:contact-border-width
   #:contact-callbacks
   #:contact-complete-class
   #:contact-complete-name
   #:contact-compress-exposures
   #:contact-compress-motion
   #:contact-constraint
   #:contact-constraints
   #:contact-depth
   #:contact-display
   #:contact-event-mask
   #:contact-glyph-cursor
   #:contact-height
   #:contact-image-cursor
   #:contact-image-mask
   #:contact-image-pixmap
   #:contact-mask
   #:contact-mode
   #:contact-name
   #:contact-parent
   #:contact-pixmap
   #:contact-root
   #:contact-root-shell
   #:contact-screen
   #:contact-sensitive
   #:contact-state
   #:contact-super-mode
   #:contact-top-level
   #:contact-translate
   #:contact-width
   #:contact-x
   #:contact-y
   #:convert
   #:cross-cursor
   #:cross-reverse-cursor
   #:crosshair-cursor
   #:data
   #:defaction
   #:default-resources
   #:defcontact
   #:defevent
   #:defimage
   #:define-resources
   #:delete-before-action
   #:delete-callback
   #:delete-child
   #:delete-event
   #:delete-mode
   #:delete-timer
   #:depth
   #:describe-action
   #:describe-event-translations
   #:describe-resource
   #:destroy
   #:destroyed-p
   #:diamond-cross-cursor
   #:dismiss
   #:display-class
   #:display-cursor
   #:display-mask
   #:display-multipress-delay-limit
   #:display-multipress-verify-p
   #:display-name
   #:display-pixmap
   ;;#:display-region -- warum geht das nich?
   #:display-root
   #:display-root-list
   #:dot-cursor
   #:dotbox-cursor
   #:double-arrow-cursor
   #:draft-large-cursor
   #:draft-small-cursor
   #:draped-box-cursor
   #:eval-action
   #:event
   #:event-actions
   #:event-translations
   #:event-window
   #:exchange-cursor
   #:fleur-cursor
   #:focus
   #:focus-p
   #:glyphs
   #:gobbler-cursor
   #:gumby-cursor
   #:hand1-cursor
   #:hand2-cursor
   #:handle-event
   #:heart-cursor
   #:height
   #:hint-p
   #:i-bar-cursor
   #:icon-cursor
   #:id
   #:ignore-action
   #:initialize-geometry
   #:inside-contact-p
   #:installed-p
   #:iron-cross-cursor
   #:key
   #:keymap
   #:kind
   #:left-ptr-cursor
   #:left-side-cursor
   #:left-tee-cursor
   #:leftbutton-cursor
   #:listen-character
   #:ll-angle-cursor
   #:lr-angle-cursor
   #:major
   #:make-contact
   #:man-cursor
   #:manage-geometry
   #:manage-priority
   #:managed-p
   #:mapped-p
   #:middlebutton-cursor
   #:minor
   #:mode
   #:mode-type
   #:mouse-cursor
   #:move
   #:move-focus
   #:name
   #:new-p
   #:next-sibling
   #:open-contact-display
   #:override-redirect-p
   #:override-shell
   #:owns-focus-p
   #:parent
   #:pencil-cursor
   #:perform-callback
   #:pirate-cursor
   #:place
   #:plist
   #:plus-cursor
   #:preferred-size
   #:present
   #:previous-sibling
   #:process-all-events
   #:process-next-event
   #:processing-event-p
   #:property
   #:question-arrow-cursor
   #:read-character
   #:realize
   #:realized-p
   #:rectangle
   #:refresh
   #:requestor
   #:resize
   #:resource
   #:right-ptr-cursor
   #:right-side-cursor
   #:right-tee-cursor
   #:rightbutton-cursor
   #:root
   #:root-x
   #:root-y
   #:rtl-logo-cursor
   #:sailboat-cursor
   #:same-screen-p
   #:sb-down-arrow-cursor
   #:sb-h-double-arrow-cursor
   #:sb-left-arrow-cursor
   #:sb-right-arrow-cursor
   #:sb-up-arrow-cursor
   #:sb-v-double-arrow-cursor
   #:selection
   #:send-event-p
   #:sensitive
   #:sensitive-p
   #:shadow-width
   #:shell
   #:shell-mapped
   #:shell-owner
   #:shell-unmapped
   #:shells
   #:shuttle-cursor
   #:sizing-cursor
   #:sm-client-host
   #:sm-command
   #:spider-cursor
   #:spraycan-cursor
   #:spring-loaded
   #:star-cursor
   #:state
   #:target
   #:target-cursor
   #:tcross-cursor
   #:throw-action
   #:top-left-arrow-cursor
   #:top-left-corner-cursor
   #:top-level-p
   #:top-level-session
   #:top-level-shell
   #:top-right-corner-cursor
   #:top-side-cursor
   #:top-tee-cursor
   #:trace-action
   #:transient-shell
   #:translate-event
   #:trek-cursor
   #:ul-angle-cursor
   #:umbrella-cursor
   #:undefevent
   #:undefine-resources
   #:unread-character
   #:update-state
   #:ur-angle-cursor
   #:using-gcontext
   #:virtual
   #:virtual-composite
   #:watch-cursor
   #:while-changing-layout
   #:width
   #:with-event
   #:with-event-mode
   #:with-mode
   #:with-wm-properties
   #:wm-base-height
   #:wm-base-width
   #:wm-colormap-owners
   #:wm-delta-height
   #:wm-delta-width
   #:wm-gravity
   #:wm-group
   #:wm-icon
   #:wm-icon-mask
   #:wm-icon-title
   #:wm-icon-x
   #:wm-icon-y
   #:wm-initial-state
   #:wm-keyboard-input
   #:wm-max-aspect
   #:wm-max-height
   #:wm-max-width
   #:wm-message
   #:wm-message-protocol
   #:wm-message-timestamp
   #:wm-min-aspect
   #:wm-min-height
   #:wm-min-width
   #:wm-protocols-used
   #:wm-shell
   #:wm-title
   #:wm-user-specified-position-p
   #:wm-user-specified-size-p
   #:x
   #:x-cursor
   #:y
   ))

(defpackage :glue-mle
  (:use :glisp)
  )

