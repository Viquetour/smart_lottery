//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription} from "./Interactions.s.sol";
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
contract DeployRaffle is Script {
       function run() external returns(Raffle, HelperConfig){
        HelperConfig helperConfig = new HelperConfig();
        (    
            uint256 entranceFee,
            uint256 interval, 
            address vrfCoordinator,
            bytes32 gasLine,
            uint64 subscriptionId,
            uint32 callbackGasLimit,             
            //address link
            
        ) = helperConfig.activeNetworkConfig();
           
           if(subscriptionId == 0){
            //We are going to create a subscribtion! 
            CreateSubscription createSubscription = new CreateSubscription();
            subscriptionId = createSubscription.createSubscription(vrfCoordinator);
            // Fund it!!  
            //I STOPED HERE!!
           }


          vm.startBroadcast();
           Raffle raffle = new Raffle(
            entranceFee,
            interval,
            vrfCoordinator,
            gasLine,
            subscriptionId,
            callbackGasLimit 
           );
          vm.stopBroadcast();

          return (raffle, helperConfig);
       }
       
}