pragma solidity ^0.4.18;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Trans is Ownable {

    function normalThing() pure
        public
    {
        // anyone can call this normalThing()
    }

    function specialThing()
        public
		view
        onlyOwner
    {
        // only the owner can call specialThing()!
    }
}