pragma solidity ^0.4.24;

contract DataExchange {
  address public owner;

  // mapping(address => mapping(address => uint256)) tx;
  mapping(address => uint) tx;
  mapping(address => address[]) customer;

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
    customer[iot_address].push(msg.sender);
  }
  
  function receive
    (address buyer_address, uint256 uid)
    public
    view
  {
    // uint amount = tx[msg.sender][buyer_address];
    uint amount = tx[buyer_address];
    buyer_address.transfer(amount);  // works in javascript VM
    // return tx[msg.sender];
  }
  
  function getBalance
    (address iot_address)
    public
    view
    returns(uint, uint)
  {
     return (tx[msg.sender], tx[iot_address]);
  }
  
  function getCustomerList
    (address iot_address)
    public
    view
    returns(address[])
  {
    return customer[iot_address];
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
