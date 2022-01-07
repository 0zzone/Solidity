pragma solidity ^0.8.7;

import './Agent.sol';

contract Catalogue {

    enum TypeBien {appartement, maison, terrain}

    struct Bien {
        string ville;
        uint price;
        Catalogue.TypeBien typeBien;
    }

    struct Client {
        string nom;
        uint numBiens;
        mapping(uint => Bien) Biens;
    }

    mapping(address => Client) Clients;


    function addBien(string memory ville, uint price, address client, uint typeBien) public {
        Bien memory b;
        bytes memory nomClient = bytes(Clients[client].nom);
        require(nomClient.length > 0, "Vous devez d'abord creer le client !");
        require(typeBien >= 0, "Le type de bien doit etre compris entre 0 et 2");
        require(typeBien <= 2, "Le type de bien doit etre compris entre 0 et 2");
        if(typeBien == 0){
            b = Bien(ville, price, TypeBien.appartement);
        }
        else if(typeBien == 1){
            b = Bien(ville, price, TypeBien.maison);
        }
        else{
            b = Bien(ville, price, TypeBien.terrain);
        }
        Clients[client].Biens[Clients[client].numBiens] = b;
        Clients[client].numBiens++;
    }

    function getBiens(address client) public view returns(string[] memory) {
        uint numBiens = Clients[client].numBiens;
        string[] memory biens = new string[](numBiens);
        for(uint i=0; i<numBiens; i++){
            biens[i] = Clients[client].Biens[i].ville;
        }
        return biens;
    }

    function getName(address client) public view returns(string memory) {
        return Clients[client].nom;
    }

    function addClient(string memory nom, address client) public {
        Clients[client].nom = nom;
    }

    function getNumBiens(address client) public view returns(uint) {
        return Clients[client].numBiens;
    }

}
