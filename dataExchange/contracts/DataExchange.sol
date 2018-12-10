pragma solidity ^0.4.24;

contract DataExchange {
  address public owner;

  // mapping(address => mapping(address => uint256)) tx;
  mapping(address => uint) tx;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function deposit
    (address iot_address, uint256 uid)
    public
    payable
  {
    // tx[iot_address][msg.sender] = msg.value;
    tx[iot_address] = msg.value;
    // this.transfer(msg.value);
  }

  function receive
    (address buyer_address, uint256 uid)
    public
  {
    // uint amount = tx[msg.sender][buyer_address];
    uint amount = tx[msg.sender];
    msg.sender.transfer(amount);
  }

  function getContractBalance
    ()
    public
    view
    returns(uint256)
  {
    return address(this).balance;
  }
}
