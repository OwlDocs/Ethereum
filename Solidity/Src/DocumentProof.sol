pragma solidity ^0.4.0;

contract DocumentProof {

    struct Proof {
        address account;
        bytes32 documentHash;
        string documentId;
        string networkTime;
    }
    
    event Generated(address account, bytes32 documentHash, string documentId, string networkTime);
    
    mapping (address => Proof[]) public accountDocumentProofs;
    mapping (bytes32 => Proof) public documentProofs;
  
    function generate(string documentId, bytes32 documentHash, string networkTime) {
        var currentProof = documentProofs[documentHash];
        
        if (currentProof.documentHash == documentHash) {
            throw;
        }
        
        var account = msg.sender;
        var proof = Proof(account, documentHash, documentId, networkTime);
        
        documentProofs[documentHash] = proof;
        accountDocumentProofs[account].push(proof);
        
        Generated(account, documentHash, documentId, networkTime);
    }
  
}