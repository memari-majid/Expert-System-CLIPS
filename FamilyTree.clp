(deftemplate father-of (slot father)(slot child))
(deftemplate mother-of (slot mother)(slot child))
(deftemplate male (slot person))
(deftemplate female (slot person))
(deftemplate wife-of (slot wife)(slot husband))
(deftemplate husband-of (slot husband)(slot wife))
(deftemplate parent-of (slot parent)(slot child))
(deftemplate aunt-of (slot aunt)(slot nephew))
(deftemplate uncle-of (slot uncle)(slot nephew))
(deftemplate sibling-of (multislot sibling))
(deftemplate cousin-of (multislot cousin))
(deftemplate grandparent-of (slot grandparent)(slot grandchild))
(deftemplate grandmother-of (slot grandmother)(slot grandchild))
(deftemplate grandfather-of (slot grandfather)(slot grandchild))
(deftemplate sister-of (slot sister)(slot person))
(deftemplate brother-of (slot brother)(slot person))

(deffacts initial-facts
    (mother-of (mother katherine)(child John))
    (mother-of (mother katherine)(child Mary))
    (mother-of (mother katherine)(child Micheal))
    (mother-of (mother Patricia)(child katherine))
    (mother-of (mother Patricia)(child Georg ))
    (mother-of (mother Patricia)(child Elizabeth))
    (father-of (father Georg )(child Alex))
    (male (person John))
    (male (person Micheal))
    (male (person Georg ))
    (male (person Alex))
    (female (person katherine))
    (female (person Mary))
    (female (person Elizabeth)))


(defrule parent
   (or (father-of (father ?p)(child ?c))
   (mother-of (mother ?p)(child ?c)))
   =>
   (assert (parent-of(parent ?p)(child ?c))))
    
(defrule sibling
     (parent-of(parent ?p)(child ?c))
     (parent-of(parent ?p)(child ?d))
     (test (neq ?c ?d))
     =>
     (assert(sibling-of(sibling ?c ?d))))
    
(defrule aunt
     (parent-of(parent ?p)(child ?c))
     (sibling-of(sibling ?p ?d))
     (female(person ?d))
     =>
     (assert(aunt-of(aunt ?d)(nephew ?c))))

(defrule uncle
     (parent-of(parent ?p)(child ?c))
     (sibling-of(sibling ?p ?d))
     (male(person ?d))
     =>
     (assert(uncle-of(uncle ?d)(nephew ?c))))

(defrule cousin    
    (or(uncle-of(uncle ?p)(nephew ?c))
     (aunt-of(aunt ?p)(nephew ?c)))
     (parent-of(parent ?p)(child ?q))
     =>
     (assert(cousin-of(cousin ?c ?q))))

(defrule grandparent   
    (parent-of(parent ?p)(child ?c))
    (parent-of(parent ?c)(child ?gc))
     =>
    (assert(grandparent-of(grandparent ?p)(grandchild ?gc))))

(defrule grandmother
     (grandparent-of(grandparent ?d)(grandchild ?gc))
     (female(person ?d))
     =>
     (assert(grandmother-of(grandmother ?d)(grandchild ?gc))))

(defrule grandfather
     (grandparent-of(grandparent ?d)(grandchild ?gc))
     (male(person ?d))
     =>
     (assert(grandfather-of(grandfather ?d)(grandchild ?gc))))

(defrule sister
     (sibling-of(sibling ?s ?p))
     (female(person ?s))
     =>
     (assert(sister-of(sister ?s)(person ?p))))

(defrule brother
     (sibling-of(sibling ?b ?p))
     (male(person ?b))
     =>
     (assert(brother-of(brother ?b)(person ?p))))