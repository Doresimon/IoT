// pragma solidity ^0.4.24;
pragma solidity <=0.5.1;

contract DataExchange {
    address public owner;

    // mapping(address => mapping(address => uint256)) tx;
    mapping(address => bool) public iot_registation;
    mapping(address => mapping(address => DEPOSIT)) public iot_tx;
    mapping(address => address[]) public customer;
    mapping(address => uint256[]) public iot_data_hash;
    mapping(uint256 => IOT_DATA) public iot_data_map;

    address[] public iot_list;

    enum State { Deposited, Accepted, Rejected }

    struct IOT_DATA {
        uint256 _hash;
        uint32  _size;
        string  _type;
        uint32  _time;
        uint256 _price;
    }

    struct DEPOSIT {
        uint256 data_hash;
        uint256 buyer_deposit;
        string  buyer_public_key;
        State   progress;
        string  data_encrypted_child_secret_key;
    }

    /* constructor */
    constructor () public {
        owner = msg.sender;
    }

    /* event */

    event AddOneIoT();

    /* library */
    modifier onlyOwner () {
        require(
            msg.sender == owner,
            "Only owner can call this"
        );
        _;
    }

    modifier beIoT (address addr) {
        require(
            iot_registation[addr],
            "Only IoT device"
        );
        _;
    }

    modifier notZero (uint256 v) {
        require(
            v > 0,
            "value should be more than zero"
        );
        _;
    }

    /* Admin */
    function registerIoT(address iot)
        public
        onlyOwner ()
        returns(bool)
    {
        bool ret;
        if (iot_registation[iot]) {
            ret = false;
        } else {
            iot_registation[iot] = true;
            iot_list.push(iot);
            ret = true;
        }
        emit AddOneIoT();
        return ret;
    }

    function getIoTList()
        public
        view
        returns(address[])
    {
        return iot_list;
    }

    /* IoT */
    function pushData(
        uint256 data_hash,
        uint32 data_size,
        string memory data_type,
        uint32 data_time,
        uint256 data_price
        )
        public
        beIoT (msg.sender)
    {

        iot_data_hash[msg.sender].push(data_hash);

        iot_data_map[data_hash]=
            IOT_DATA(
                {
                    _hash:  data_hash,
                    _size:  data_size,
                    _type:  data_type,
                    _time:  data_time,
                    _price: data_price
                }
            );

    }

    /* Exchange */
    function deposit (
        address iot_address,
        uint256 data_hash,
        string memory pk
        )
        public
        payable
        beIoT (iot_address)
        notZero (msg.value)
    {
        require(
            iot_data_map[data_hash]._price == msg.value, 
            "deposit should be equal to supposed price"
        );

        iot_tx[iot_address][msg.sender] = DEPOSIT({
                data_hash:data_hash,
                buyer_deposit: msg.value,
                buyer_public_key: pk,
                data_encrypted_child_secret_key: '',
                progress:   State.Deposited
            });
        customer[iot_address].push(msg.sender);
    }
    
    function deal (
        address buyer_address, 
        string memory encrypted_csk
        )
        public
        beIoT (msg.sender)
    {
        uint amount = iot_tx[msg.sender][buyer_address].buyer_deposit;
        iot_tx[msg.sender][buyer_address].data_encrypted_child_secret_key = encrypted_csk;
        iot_tx[msg.sender][buyer_address].progress = State.Accepted;
        
        msg.sender.transfer(amount); // works in javascript VM
    }

    /* Utility */
    // function getBalance (address iot_address)
    //     public
    //     view
    //     returns(uint)
    // {
    //     return iot_tx[iot_address];
    // }
    
    function getCustomerList (address iot_address)
        public
        view
        returns(address[] memory)
    {
        address[] memory c = customer[iot_address];
        return c;
    }

    function getContractBalance ()
        public
        view
        returns(uint256)
    {
        return address(this).balance;
    }
}
