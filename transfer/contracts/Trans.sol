pragma solidity ^0.4.18;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";

contract Trans is Ownable {

    struct D {
        uint256 h;
        uint256 uid;
        uint256 timeStamp;
        uint256 dataSize;
        uint256 supposedPrice;
        string  dataType;
    }
    struct IoT {
        address a;
        string info;
    }
    mapping(address => D[]) DB;
    mapping(address => string) IoTInfo;
    IoT[]  IoTList;

    Roles.Role IoTDevice;
    address creator;  // the boss

    constructor () public {
        creator = msg.sender;
    }

    // registerIoT
    // the creator use this
    // to add IoT device's address 
    // in the smart contract
    function registerIoT(address addr, string info)
        payable
        public
        onlyOwner
        returns(uint256)
    {
        require(!Roles.has(IoTDevice, addr), "IoT Device Already Exists");

        Roles.add(IoTDevice, addr);
        IoTList.push(
            IoT(
                {
                    a:addr,
                    info:info
                }
            )
        );
        IoTInfo[addr] = info;

        return msg.value;
    }

    // unregisterIoT
    // same as register IoT
    function unregisterIoT(address addr)
        public
        onlyOwner
    {
        require(Roles.has(IoTDevice, addr), "IoT Device Doesn't Exist");

        Roles.remove(IoTDevice, addr);
    }

    function readIoT(uint index)
        public
        view
        returns(string)
    {
        return IoTList[index].info;
    }

    // IoT device push new data
    function newData(
        uint256 h,
        uint256 uid,
        uint256 timeStamp,
        uint256 dataSize,
        uint256 supposedPrice,
        string  dataType
        )
        public
    {   
        require(Roles.has(IoTDevice, msg.sender), "IoT Device Supposed");
        DB[msg.sender].push(
            D(
                {
                    h:h,
                    uid:uid,
                    timeStamp:timeStamp,
                    dataSize:dataSize,
                    supposedPrice:supposedPrice,
                    dataType: dataType
                }
            )
        );
    }

    // search data
    function searchData(address addr, uint256 ts)
        public
        view
        returns(
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            string
        )
    {

        for (uint i = 0; i < DB[addr].length; i++) {
            if (ts==DB[addr][i].timeStamp) {
                return(
                    DB[addr][i].h,
                    DB[addr][i].uid,
                    DB[addr][i].timeStamp,
                    DB[addr][i].dataSize,
                    DB[addr][i].supposedPrice,
                    DB[addr][i].dataType
                );
            }
        }
         
    }

    function buyData(address iot, uint256 uid)
        payable
        public
        returns(uint256)
    {
        // transfer to safe box

        return msg.value;

        // address payable x = msg.sender
        
        
    }

    function TranToken(address addr, uint256 val)
        payable
        public
        onlyOwner
        returns(bool)
    {
        // address payable a = addr;
        bool r = addr.send(val);
        // bool r = a.send(val);
        return r;
    }
}