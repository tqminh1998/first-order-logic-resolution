from itertools import permutations

class Predicate:
    def __init__(self, predicate_name, params):
        self.predicate_name = predicate_name
        self.params = params

class Rule:
    def __init__(self, q, list_predicates):
        self.q = q
        self.list_predicates = list_predicates

class Subs:
    def __init__(self, var, val):
        self.var = var
        self.val = val


class KB:
    def __init__(self):
        self.rules = []
        self.predicates = []
        self.substitutions = []
        self.variables = []


    def read_to_KB(self):        
        file_in = open("Doan2.pl", "r")
        
        inp = file_in.readline()
        
        while (inp):
            if inp == "Domains\n":
                inp = file_in.readline()
                self.variables = list(map(str, inp.split(',')))

            elif inp.find("'") != -1:
                self.predicates.append(create_predicate_from_string(inp))
            
            elif inp[0].isalpha():
                list_q_predicates = list(map(str, inp.split(":-")))
                
                list_preds = create_list_preds_from_rule(list_q_predicates[1])

                self.rules.append(Rule(list_q_predicates[0], list_preds))


            inp = file_in.readline()

        #standardized string
        for i in range(len(self.variables)):
            self.variables[i] = delete_space(delete_enter(self.variables[i]))


        file_in.close()

    def create_subs_list(self):
        for rule in self.rules:
            x = []
            for p in rule.list_predicates:
                x.append(create_predicate_from_string(p))
            
            #print(x[0].predicate_name, x[0].params)

            for pred in self.predicates:
                y=[]
                y.append(pred)
                mgu = Unify(x, y, [])
                if mgu != None:
                    self.substitutions.append(mgu)
                
        
def delete_enter(s):
    if s.find("\n") != -1:
        return s[0:s.find("\n")]
    return s

def delete_space(s):
    i=0
    while s[i] == ' ' or s[i] == ',':
        i+=1
    
    j=len(s) - 1

    while s[j] == ' ' or s[j] == ',':
        j-=1

    return s[i:(j+1)]


def create_list_preds_from_rule(str_rule):
    list_preds = []
    pos = str_rule.find(")")

    tmp = ""
    cur_pos = 0
    while pos != -1:
        for i in range(cur_pos, pos+1, 1):
            tmp+=str_rule[i]
        
        list_preds.append(tmp)
        tmp = ""
        
        cur_pos = pos+1
        pos = str_rule.find(")", pos + 1, len(str_rule))
        

    for i in range(len(list_preds)):
        list_preds[i] = delete_space(list_preds[i])

    true_list_preds = []

    for i in range(len(list_preds)):
        true_list_preds.append(create_predicate_from_string(list_preds[i]))

    return true_list_preds

        
def create_predicate_from_string(pred):
    pred_name = pred[0:pred.find("(")]
    str_param = pred[(pred.find("(") + 1) : pred.find(")")]

    params = list(map(str, str_param.split(',')))
    
    for i in range(len(params)):
        params[i] = delete_space(params[i])
    
    return Predicate(pred_name, params)


def isVar(x):
    return len(x) == 1 and x[0] in kb.variables

def isPredicate(x):
    return len(x) == 1 and str(type(x[0])) == "<class '__main__.Predicate'>"


def BoundTo(var, s):
    for theta in s:
        if theta.var == var:
            #print(var)
            return theta.val
    
    return None

def Occur(var, x, s):
    return False
            

def UnifyVar(var,x,s):
    if BoundTo(var, s) != None:
        val = BoundTo(var,s)
        return Unify(val, x, s)
    elif isVar(x):
        if BoundTo(x,s) != None:
            val = BoundTo(x,s)
            return UnifyVar(var, val, s)
    elif Occur(var,x,s):
        s = ['fail']
        return s
    else:
        s.append(Subs(var, x))
        return s


    return None

def Unify(x, y, s):
    if s == None:
        return None
    elif isVar(x):
        return UnifyVar(x,y,s)
    elif isVar(y):
        return UnifyVar(y,x,s)
    elif isPredicate(x):
        if isPredicate(y) and y[0].predicate_name == x[0].predicate_name:
            return Unify(x[0].params, y[0].params, s)
        else:
            return None
    elif len(x) == len(y) and len(x) == 1:
        if x == y:
            return s
        else:
            return None
    else:
        return Unify(x[1:], y[1:], Unify(x[0:1], y[0:1], s))


def fol_fc_ask(alpha):
    
    new = ['1']
    while len(new) != 0:
        new = []
        for rule in kb.rules:    

            all_sub = create_all_sub(rule)

            q = rule.q

            for sub in all_sub:
                # for i in range(len(sub)):
                #     print(sub[i].var, sub[i].val)
                
                # print()

                q_res = None
                q_res = SUBST(sub, q)
                #print(q_res.predicate_name, q_res.params)

                if q_res not in new:
                    new.append(q_res)
                    alpha_list = []
                    alpha_list.append(alpha)
                    q_res_list = []
                    q_res_list.append(q_res)
                    phi = Unify(alpha_list,q_res_list,[])

                    if phi != None:
                        return phi

        break
    
    return None

def SUBST(sub, q):

    q_r = create_predicate_from_string(q)

    for i in range(len(q_r.params)):
        for s in sub:
            if s.var[0] == q_r.params[i]:
                q_r.params[i] = s.val[0]
                break
    
    
    return q_r


def create_all_sub(rule):
    
    relevant = []
    for element in rule.list_predicates:
        for pred in kb.predicates:
            if element.predicate_name == pred.predicate_name:
                relevant.append(pred)
                
    
    x = list(permutations(relevant, len(rule.list_predicates)))
    
    all_sub = []
    for i in range(len(x)):
        tmp = []
        for r in x[i]:
            tmp.append(r)

        s = Unify(rule.list_predicates, tmp, [])

        
        if s != None:
            all_sub.append(s)


    return all_sub
   


def main():
    file_query = open("query.txt", "r")

    alpha = str(file_query.readline())
    while alpha:

        alpha = create_predicate_from_string(alpha)

        s = fol_fc_ask(alpha)

        if s != None:
            for i in range(len(s)):
                print(s[i].var, s[i].val)
        else:
            print('None')

        alpha = file_query.readline()

    file_query.close()


if __name__ == '__main__':
    kb = KB()
    kb.read_to_KB()
    main()