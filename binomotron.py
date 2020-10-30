import random
import math
import tkinter
from tkinter import ttk
import mysql.connector as mysql
from datetime import datetime


class MySQL_link:
    #Créer une classe link qui pourra être utilisée pour tout import/export de données vers la base
    def __init__(self):
        self.link = mysql.connect(host='localhost', password='root', user='root', database='binomotron')
        self.cursor = self.link.cursor()

    
def obtenir_noms():
    #Fonction obtenir_nom qui permet de récupérer les id/prenom/noms depuis la base de donnée
    link.cursor.execute("SELECT id_apprenant, prenom_apprenant, nom_apprenant FROM apprenants")
    #Utiliser fetchall pour stocker les valeurs dans une liste
    personnes = link.cursor.fetchall()
    return personnes


def creer_groupes(personnes, personnes_par_groupe):
    #Fonction creer_groupes qui va utiliser les données pour les séparer en groupes aléatoire
    #Définir le nombre de groupes à créer
    number_of_groups = math.ceil(len(personnes) / personnes_par_groupe)
    #Mélanger la liste
    random.shuffle(personnes)
    x = 0
    i = 1
    groupes = {}
    #Créer des listes tant que le nombre de groupes n'est pas atteint en utilisant un index 
    while len(groupes) < number_of_groups:
        # Découper la liste principale en plusieurs parties pour chaques groupes
        team = personnes[x:x+personnes_par_groupe]
        x += personnes_par_groupe
        #Ajouter la liste au dictionnaire
        groupes[i] = team
        i += 1

    afficher_groupes(groupes)
    creer_projet(groupes)


def afficher_groupes(groupes):    
    #Créer le Treeview pour l'affichage des noms
    tree = ttk.Treeview(window, columns=('group', 'people'))

    #Afficher chaque ligne une par une
    for i in groupes.keys():
        # Passer de tuples à un seul string pour l'affichage du groupe
        noms=[item[1:3] for item in groupes[i]]
        noms = '  ||  '.join(' '.join(i) for i in noms)
        # Insérer la string
        tree.insert(parent='', index='end', values=(i, noms))

    #Paramétrage graphique du Treeview
    tree.column('group', width=75, minwidth=75)
    tree.column('people', width=700, minwidth=300)
    tree.heading('group', text='Groupe n°')
    tree.heading('people', text='Personnes')
    tree['show'] = 'headings'
    tree.place(x=10, y=125)


def creer_projet(groupes):
    # Recuperer la date du jour et la transformer dans le format requis dans la bdd
    date_projet = datetime.now().strftime("%Y/%m/%d")
    nom_projet = entry_nom_projet.get()

    query = "INSERT INTO `projets` (`id_projet`, `nom_projet`, `date_projet`) VALUES (%s, %s, %s)"
    # Créer un projet dans la bdd avec un nom et la date du jour
    data = (None, nom_projet, date_projet)
    link.cursor.execute(query, data)
    link.link.commit()
    
    print(f'Projet: "{nom_projet}" créé')
    # lastrowid permet d'obtenir l'ID du projet créé
    exporter_donnees(link.cursor.lastrowid, groupes)


def exporter_donnees(id_projet, groupes):
    # Ligne SQL pour exporter les données (nom/groupe/projet) pour chaque personne
    query = "INSERT INTO `apprenant_groupe_projet` (`id_projet`, `id_apprenant`, `id_groupe`) VALUES (%s, %s, %s)"

    #Stocker dans la base de données pour chaque personnes
    for i in groupes.keys():
        for personne in groupes[i]:
            data = (id_projet, personne[0], i)
            link.cursor.execute(query, data)
            link.link.commit()
    print('Valeurs exportées')

# Tenter une connexion avec la base de données
try:
    link = MySQL_link()
    personnes = obtenir_noms()
except:
    print("Connexion impossible à la base de données")
    quit()

# Création de la fenetre Tkinter
window = tkinter.Tk()
window.title('Binômotron')
window.geometry('800x500')
window.configure(bg='#ce0033')
window.resizable(width=False, height=False)

# Nom du projet
binomotron_label = tkinter.Label(font=('Helvetica', '50'), fg='black', bg='#ce0033', text="Binômotron")
binomotron_label.place(x=230, y=25)

# Noms des createurs du projet
nom_pereg = tkinter.Label(font=('Helvetica', '15'), fg='black', bg='#ce0033', text="Pereg Hergoualc'h")
nom_pereg.place(x=10, y=470)
nom_baptiste = tkinter.Label(font=('Helvetica', '15'), fg='black', bg='#ce0033', text="Baptiste Le Berre")
nom_baptiste.place(x=625, y=470)

# Champ de saisie pour le nom du groupe
entry_nom_projet = tkinter.Entry(font=('Helvetica', '10'), relief='flat', width=40, justify='center', fg='black', bg='#d9d9d9')
entry_nom_projet.insert(1, 'Nom du projet?')
entry_nom_projet.place(x=260, y=375)

# Champ de saisie pour le nomrbe de personnes par groupes
entry = tkinter.Entry(font=('Helvetica', '10'), relief='flat', width=10, justify='center', fg='black', bg='#d9d9d9')
entry.insert(1, '2')
entry.place(x=365, y=410)

# Boutton pour générer les groupes et les afficher
button = tkinter.Button(height=2, width=20, bg='#d9d9d9', text="Générer", command=lambda: creer_groupes(personnes, int(entry.get())))
button.place(x=325, y=450)

window.mainloop()
