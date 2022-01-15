pragma solidity ^0.8.7;

contract Recette {

    enum Difficulty {facile, moyen, difficile}

    struct infosRecette {
        string name;
        uint time;
        uint nombreIngredients;
        string[] ingredients;
        Recette.Difficulty difficulty;
    }

    mapping(address => infosRecette) Recettes;

    function getRecette(address _address) public view returns(infosRecette memory) {
        return Recettes[_address];
    }

    function getDifficulty(address _address) public view returns(Difficulty){
        return Recettes[_address].difficulty;
    }

    function getTime(address _address) public view returns(uint) {
        return Recettes[_address].time;
    }

    function getIngredients(address _address) public view returns(string[] memory) {
        uint numIngredients = Recettes[_address].nombreIngredients;
        string[] memory ingredients = new string[](numIngredients);
        for(uint i=0; i<numIngredients; i++){
            ingredients[i] = Recettes[_address].ingredients[i];
        }
        return ingredients;
    }

    function addIngredients(address _address, string[] memory _ingredients, uint _nombreIngredients) public {
        require(_ingredients.length == _nombreIngredients, "Nombres incorrects !");
        Recettes[_address].nombreIngredients = _nombreIngredients;
        for(uint i=0; i<_ingredients.length; i++){
            Recettes[_address].ingredients.push(_ingredients[i]);
        }
    }

    function addRecette(address _address, string memory _name, uint _time, uint _difficulty) public {
        bytes memory name = bytes(Recettes[_address].name);
        require(name.length == 0, "La recette a deja ete cree !");
        require(_difficulty >= 0, "La difficulte doit etre comprise entre 0 et 2");
        require(_difficulty <= 2, "La difficulte doit etre comprise entre 0 et 2");
        Recettes[_address].name = _name;
        Recettes[_address].time = _time;
        if(_difficulty == 0){
            Recettes[_address].difficulty = Difficulty.facile;
        }
        else if(_difficulty == 1){
            Recettes[_address].difficulty = Difficulty.moyen;
        }
        else{
            Recettes[_address].difficulty = Difficulty.difficile;
        }
    }

    function getRecetteName(address _address) public view returns(string memory) {
        return Recettes[_address].name;
    }

}
