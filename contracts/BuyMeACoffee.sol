//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract BuyMeACoffee {
    //Event to Emit when new memo
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo Struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos recieved
    Memo[] memos;


    // Address of Contract Deployer
    address owner;
    address payable withdrawAddress;

    //Deploy
    constructor() {
        owner = msg.sender;
        withdrawAddress = payable(msg.sender);

    }

    /**
     * @dev Buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message message from the coffee buyer
     */


    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0,'cant buy coffee with 0 eth');

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));



        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
     * @dev Send the entire balance stored in the contract to the owner
     */

    function withdrawTips() public {
        require(withdrawAddress.send(address(this).balance));
    }
    
    
    /**
     * @dev Send the entire balance stored in the contract to the owner
     */

    function changeWithdrawAddress(address payable _newAddress) public {
        require(msg.sender == owner);
        withdrawAddress = _newAddress;
    }

    /**
     * @dev Send the entire balance stored in the contract to the owner
     */

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
    


}